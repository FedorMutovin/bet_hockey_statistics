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
      sign_in(user)
      click_on account.bookmaker.name
      within '.transfer_form' do
        fill_in 'Operation amount', with: '123'
        select 'deposit', from: 'transfer[result]'
        click_on 'Save'
      end

      expect(page).to have_content 'successful'
      visit account_path(account)
      expect(page).to have_content '123'
    end
  end

  context 'when user tries withdrawal', js: true do
    let!(:account) { create(:account, user: user, balance: 123) }

    before { sign_in(user) }

    it 'successful withdrawal' do
      click_on account.bookmaker.name
      within '.transfer_form' do
        fill_in 'Operation amount', with: '123'
        select 'withdrawal', from: 'transfer[result]'
        click_on 'Save'
      end

      expect(page).to have_content 'successful'
      visit account_path(account)
      expect(page).to have_content '0'
    end

    it 'not successful withdrawl' do
      click_on account.bookmaker.name
      within '.transfer_form' do
        fill_in 'Operation amount', with: '1000'
        select 'withdrawal', from: 'transfer[result]'
        click_on 'Save'
      end

      expect(page).to have_content 'Insufficient funds'
      visit account_path(account)
      expect(page).to have_content '123'
    end
  end
end
