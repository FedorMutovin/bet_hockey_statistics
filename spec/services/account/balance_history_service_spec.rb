require 'rails_helper'

RSpec.describe Account::BalanceHistoryService do
  let(:user) { create(:user) }
  let(:account) { create(:account) }
  let(:win_bet) { create(:bet, result: 'win', winning_amount: 200) }
  let(:lose_bet) { create(:bet, result: 'lose') }
  let(:deposit) { create(:transfer) }
  let(:withdrawal) { create(:transfer, :withdrawal) }
  let!(:deposit_operation) do
    create(:operation, account: account, user: user, operational: deposit,
                       created_at: Time.zone.now - 3.days)
  end
  let!(:win_operation) do
    create(:operation, account: account, user: user, operational: win_bet,
                       created_at: Time.zone.now - 2.days)
  end
  let!(:lose_operation) do
    create(:operation, account: account, user: user, operational: lose_bet,
                       created_at: Time.zone.now - 1.day)
  end
  let!(:withdrawal_operation) { create(:operation, account: account, user: user, operational: withdrawal) }

  context 'when account has operations' do
    it 'return right values in hash' do
      operations_values = {
        Date.current - 3.days => 100.0,
        Date.current - 2.days => 200.0,
        Date.current - 1.day => 100.0,
        Date.current => 0.0
      }
      expect(described_class.call(account.operations).history).to eq(operations_values)
    end
  end
end
