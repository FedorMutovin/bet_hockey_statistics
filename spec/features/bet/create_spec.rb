require 'rails_helper'

describe 'User can do bet on event', "
 In order to have to be able to do bet on event
 As an user
 I'd like to be able to do bet on event
" do
  let(:user) { create(:user) }
  let(:home_team) { create(:team) }
  let(:away_team) { create(:team) }
  let(:season) { create(:season) }
  let(:regular_season) { create(:regular_season, season: season) }
  let!(:game) { create(:game, home_team: home_team, away_team: away_team, season: season, gameable: regular_season) }

  context 'when user tries bet', js: true do
    let!(:account) { create(:account, user: user, balance: 100) }

    it 'successful bet' do
      visit user_path(user)
      within '.bet_form' do
        fill_in 'Operation amount', with: '10'
        select game.name_for_bet, from: 'bet[event_attributes][game_id]'
        select 'match_winner', from: 'bet[event_attributes][name]'
        select account.bookmaker.name, from: 'bet[operation_attributes][account_id]'
        fill_in 'Choose odds', with: '1.7'
        select home_team.name, from: 'bet[event_attributes][team_id]'
        click_on 'Save'
      end

      expect(page).to have_content 'successful'
      visit user_path(user)
      within '.overall-balance' do
        expect(page).to have_content '90'
      end
      within '.operations' do
        expect(page).to have_content 'pending'
      end
    end
  end

  context 'when user tries bet without balance', js: true do
    let!(:account) { create(:account, user: user, balance: 100) }

    it 'not successful bet' do
      visit user_path(user)
      within '.bet_form' do
        fill_in 'Operation amount', with: '101'
        select game.name_for_bet, from: 'bet[event_attributes][game_id]'
        select 'match_winner', from: 'bet[event_attributes][name]'
        select account.bookmaker.name, from: 'bet[operation_attributes][account_id]'
        fill_in 'Choose odds', with: '1.7'
        select home_team.name, from: 'bet[event_attributes][team_id]'
        click_on 'Save'
      end
      expect(page).to have_content 'Insufficient funds'
      visit user_path(user)
      within '.overall-balance' do
        expect(page).to have_content '100'
      end
      within '.operations' do
        expect(page).not_to have_content 'pending'
      end
    end
  end
end
