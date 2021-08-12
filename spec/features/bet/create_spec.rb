require 'rails_helper'

describe 'User can do bet on event', "
 In order to have to be able to do bet on event
 As an user
 I'd like to be able to do bet on event
" do
  let(:user) { create(:user) }

  League::AVAILABLE_LEAGUES_NAMES.map(&:downcase).each do |league|
    let!("#{league}_league".to_sym) { create(:league, league.to_sym) }
    let("#{league}_home_team".to_sym) { create(:team, league.to_sym, league: send("#{league}_league".to_sym)) }
    let("#{league}_away_team".to_sym) { create(:team, league.to_sym, league: send("#{league}_league".to_sym)) }
    let("#{league}_season".to_sym) { create(:season, league.to_sym, league: send("#{league}_league".to_sym)) }
    let("#{league}_regular_season".to_sym) { create(:regular_season, season: send("#{league}_season".to_sym)) }
    let!("#{league}_game".to_sym) do
      create(:game,
             league: send("#{league}_league".to_sym),
             season: send("#{league}_season".to_sym),
             home_team: send("#{league}_home_team".to_sym),
             away_team: send("#{league}_away_team".to_sym),
             gameable: send("#{league}_regular_season".to_sym))
    end
    let!(:total) { create(:total) }
  end

  context 'when user tries bet', js: true do
    let!(:account) { create(:account, user: user, balance: 100) }

    it 'successful bet' do
      visit user_path(user)
      within '.search-form' do
        select nhl_league.name, from: 'league_name'
        click_on 'choose league for bet'
      end
      within '.new-bet' do
        fill_in 'Operation amount', with: '10'
        select nhl_game.name_for_bet, from: 'bet[event_attributes][game_id]'
        select 'Total', from: 'bet[event_attributes][eventable_type]'
        select '< 5.0', from: 'bet[event_attributes][eventable_id]'
        select account.bookmaker.name, from: 'bet[operation_attributes][account_id]'
        fill_in 'Choose odds', with: '1.7'
        click_on 'Save'
      end

      expect(page).to have_content 'successful'
      visit user_path(user)
      expect(page).to have_content '90'
      within '.operations' do
        expect(page).to have_content 'pending'
      end
    end
  end

  context 'when user tries bet without balance', js: true do
    let!(:account) { create(:account, user: user, balance: 100) }
    let!(:match_winner) { create(:match_winner) }

    it 'not successful bet' do
      visit user_path(user)
      within '.search-form' do
        select khl_league.name, from: 'league_name'
        click_on 'choose league for bet'
      end
      within '.new-bet' do
        fill_in 'Operation amount', with: '101'
        select khl_game.name_for_bet, from: 'bet[event_attributes][game_id]'
        select 'MatchWinner', from: 'bet[event_attributes][eventable_type]'
        select 'with_extra_time: true', from: 'bet[event_attributes][eventable_id]'
        select account.bookmaker.name, from: 'bet[operation_attributes][account_id]'
        fill_in 'Choose odds', with: '1.7'
        select khl_home_team.name, from: 'bet[event_attributes][team_id]'
        click_on 'Save'
      end
      expect(page).to have_content 'Insufficient funds'
      visit user_path(user)
      expect(page).to have_content '100'
      within '.operations' do
        expect(page).not_to have_content 'pending'
      end
    end
  end
end
