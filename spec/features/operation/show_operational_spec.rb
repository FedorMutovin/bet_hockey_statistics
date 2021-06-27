require 'rails_helper'

describe 'User can show operational info', "
 In order to have to be able to see operation info
 As an user
 I'd like to be able to show operation info
" do
  let(:account) { create(:account) }
  let(:bet) { create(:bet) }
  let(:transfer) { create(:transfer) }
  let!(:operation_with_bet) { create(:operation, :with_bet, account: account, operational: bet) }
  let!(:operation_with_transfer) { create(:operation, :with_transfer, account: account, operational: transfer) }

  context 'when account have operations' do
    it 'show operational fields' do
      [bet, transfer].each do |operational|
        visit account_path(account)
        click_on send("operation_with_#{operational.class.name.downcase}").id
        operational.attribute_names.each { |attr| expect(page).to have_content operational.send(attr) }
      end
    end
  end
end
