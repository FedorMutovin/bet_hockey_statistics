require 'rails_helper'

describe 'User can view his profile', "
 In order to have to be able to see my profile
 As an user
 I'd like to be able to view all my profile
" do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:other_account) { create(:account, user: user) }
  let(:bet) { create(:bet) }
  let(:transfer) { create(:transfer) }
  let!(:operation) { create(:operation, operational: bet, account: account, user: user) }
  let!(:other_operation) { create(:operation, operational: transfer, account: other_account, user: user) }
  let(:current_balance) { (account.balance + other_account.balance - bet.amount + transfer.amount).to_i }

  context 'when user tries log in', js: true do
    it 'log in user and show profile' do
      visit root_path
      sign_in(user)
      expect(page).to have_content user.email
      expect(page).to have_content current_balance
      expect(page).to have_content operation.operational.result
      expect(page).to have_content operation.operational_id
      expect(page).to have_content other_operation.operational.result
      expect(page).to have_content other_operation.operational_id
      expect(page).to have_content account.bookmaker.name
      expect(page).to have_content other_account.bookmaker.name
    end
  end
end
