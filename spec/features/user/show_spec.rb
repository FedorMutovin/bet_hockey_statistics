require 'rails_helper'

describe 'User can view his profile', "
 In order to have to be able to see my profile
 As an user
 I'd like to be able to view all my profile
" do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:bet) { create(:bet) }
  let!(:operation) { create(:operation, operational: bet, account: account, user: user) }

  context 'when user tries log in' do
    it 'log in user and show profile' do
      visit root_path
      sign_in(user)
      expect(page).to have_content user.email
      expect(page).to have_content operation.operational.result
      expect(page).to have_content operation.operational_id
    end
  end
end
