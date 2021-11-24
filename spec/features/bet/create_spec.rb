require 'rails_helper'

describe 'User can do bet on event', "
 In order to have to be able to do bet on event
 As an user
 I'd like to be able to do bet on event
" do
  let(:user) { create(:user) }

  let(:league) { create(:league) }
  let(:home_team) { create(:team, league: league) }
  let(:away_team) { create(:team, league: league) }
  let(:season) { create(:season, league: league) }
  let(:regular_season) { create(:regular_season, season: season) }
  let!(:game) do
    create(:game,
           league: league,
           season: season,
           home_team: home_team,
           away_team: away_team,
           gameable: regular_season)
  end
  let!(:total) { create(:total) }

  context 'when user tries bet', js: true do
    let!(:account) { create(:account, user: user, balance: 100) }

    it 'successful bet' do
      sign_in(user)
      within '.search-form' do
        select league.name, from: 'league_name'
        click_on 'choose league for bet'
      end
      within '.new-bet' do
        fill_in 'Operation amount', with: '10'
        select game.name_for_bet, from: 'bet[event_attributes][game_id]'
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
      sign_in(user)
      within '.search-form' do
        select league.name, from: 'league_name'
        click_on 'choose league for bet'
      end
      within '.new-bet' do
        fill_in 'Operation amount', with: '101'
        select game.name_for_bet, from: 'bet[event_attributes][game_id]'
        select 'MatchWinner', from: 'bet[event_attributes][eventable_type]'
        select 'with_extra_time: true', from: 'bet[event_attributes][eventable_id]'
        select account.bookmaker.name, from: 'bet[operation_attributes][account_id]'
        fill_in 'Choose odds', with: '1.7'
        select home_team.name, from: 'bet[event_attributes][team_id]'
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
