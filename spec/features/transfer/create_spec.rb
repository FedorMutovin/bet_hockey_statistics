require 'rails_helper'

describe 'User can do transfer(deposit ot withdraw)', "
 In order to have to be able to do transfer(deposit ot withdraw)
 As an user
 I'd like to be able to do transfer(deposit ot withdraw)
" do
  let(:user) { create(:user) }

  context 'when user tries deposit', js: true do
    let!(:account) { create(:account, user: user, balance: 0) }

    it 'successful deposit' do
      visit user_path(user)
      within '.transfer_form' do
        fill_in 'Operation amount', with: '123'
        select 'deposit', from: 'transfer[category]'
        select account.bookmaker.name, from: 'transfer[operation_attributes][account_id]'
        click_on 'Save'
      end

      expect(page).to have_content 'successful'
      visit user_path(user)
      within '.overall-balance' do
        expect(page).to have_content '123'
      end
    end
  end

  context 'when user tries withdrawal', js: true do
    let!(:account) { create(:account, user: user, balance: 123) }

    it 'successful withdrawal' do
      visit user_path(user)
      within '.transfer_form' do
        fill_in 'Operation amount', with: '123'
        select 'withdrawal', from: 'transfer[category]'
        select account.bookmaker.name, from: 'transfer[operation_attributes][account_id]'
        click_on 'Save'
      end

      expect(page).to have_content 'successful'
      visit user_path(user)
      within '.overall-balance' do
        expect(page).to have_content '0'
      end
    end

    it 'not successful withdrawl' do
      visit user_path(user)
      within '.transfer_form' do
        fill_in 'Operation amount', with: '1000'
        select 'withdrawal', from: 'transfer[category]'
        select account.bookmaker.name, from: 'transfer[operation_attributes][account_id]'
        click_on 'Save'
      end

      expect(page).to have_content 'Insufficient funds'
      visit user_path(user)
      within '.overall-balance' do
        expect(page).to have_content '123'
      end
    end
  end
end
