require 'rails_helper'

describe 'User can show all of users and go to profile', "
 In order to have to be able to see all users and go to profile
 As an user
 I'd like to be able to show all of users and go to profile
" do
  let(:users) { create_list(:user, 2) }
  let(:accounts) { create_list(:account, 2, user: users.first) }
  let(:bet) { create(:bet) }
  let!(:operation) { create(:operation, operational: bet, account: accounts.first, user: users.first) }

  context 'when user tries see all users and go to profile' do
    it 'user tries see all users and go to profile' do
      puts operation
      visit users_path
      users.each { |user| expect(page).to have_content user.mobile_phone }
      first_user = users.first
      click_on first_user.mobile_phone
      accounts.each do |account|
        expect(page).to have_content account.balance
        expect(page).to have_content account.number
      end
      expect(page).to have_content operation.operational.result
      expect(page).to have_content operation.operational_id
    end
  end
end
