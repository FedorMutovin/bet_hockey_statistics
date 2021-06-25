require 'rails_helper'

describe 'User can show all of his accounts and go to account by link', "
 In order to have to be able to see all account and go to account
 As an user
 I'd like to be able to show all of my conversations and go to account
" do
  let(:accounts) { create_list(:account, 2) }
  let!(:operation) { create(:operation, :with_bet, account: accounts.first) }

  it 'user tries see all accounts and go to one of them' do
    visit accounts_path
    puts operation.account
    accounts.each { |account| expect(page).to have_content account.number }
    first_account = accounts.first
    click_on first_account.number
    expect(page).to have_content first_account.balance
    expect(page).to have_content first_account.number
    expect(page).to have_content operation.operational_type
    expect(page).to have_content operation.operational_id
  end
end
