require 'rails_helper'

RSpec.describe Account::ChangeBalanceService do
  let(:user) { create(:user) }
  let(:account) { create(:account) }
  let(:win_bet) { create(:bet, result: 'win', winning_amount: 200) }
  let(:lose_bet) { create(:bet, result: 'lose') }
  let(:deposit) { create(:transfer) }
  let(:withdrawal) { create(:transfer, :withdrawal) }
  let!(:win_operation) { create(:operation, account: account, user: user, operational: win_bet) }
  let!(:lose_operation) { create(:operation, account: account, user: user, operational: lose_bet) }
  let!(:deposit_operation) { create(:operation, account: account, user: user, operational: deposit) }
  let!(:withdrawal_operation) { create(:operation, account: account, user: user, operational: withdrawal) }

  context 'when deposit operation' do
    it 'update balance like deposit with bet' do
      account_balance = account.balance
      described_class.new(account, win_bet).call
      account.reload
      expect(account.balance).to eq(account_balance + win_bet.winning_amount)
    end

    it 'update balance like deposit with transfer' do
      account_balance = account.balance
      described_class.new(account, deposit).call
      account.reload
      expect(account.balance).to eq(account_balance + deposit.amount)
    end
  end

  context 'when withdrawal operation' do
    it 'update balance like withdrawal with bet' do
      account_balance = account.balance
      described_class.new(account, lose_bet).call
      account.reload
      expect(account.balance).to eq(account_balance - lose_bet.amount)
    end

    it 'update balance like withdrawal with transfer' do
      account_balance = account.balance
      described_class.new(account, withdrawal).call
      account.reload
      expect(account.balance).to eq(account_balance - withdrawal.amount)
    end
  end
end
