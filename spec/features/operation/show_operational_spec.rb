require 'rails_helper'

describe 'User can show operational info', "
 In order to have to be able to see operation info
 As an user
 I'd like to be able to show operation info
" do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:bet) { create(:bet) }
  let(:transfer) { create(:transfer) }
  let!(:operation_with_bet) { create(:operation, :with_bet, account: account, operational: bet, user: user) }
  let!(:operation_with_transfer) do
    create(:operation, :with_transfer, account: account, operational: transfer, user: user)
  end

  context 'when account have operations' do
    it 'show operational fields' do
      sign_in(user)
      [bet, transfer].each do |operational|
        click_on send("operation_with_#{operational.class.name.downcase}").id
        operational.attribute_names.each { |attr| expect(page).to have_content operational.send(attr) }
        visit account_path(account)
      end
    end
  end
end
