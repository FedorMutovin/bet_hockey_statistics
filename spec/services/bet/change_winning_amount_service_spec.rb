require 'rails_helper'

RSpec.describe Bet::ChangeWinningAmountService do
  let(:user) { create(:user) }
  let(:account) { create(:account) }
  let(:win_bet) { create(:bet, result: 'win') }
  let(:lose_bet) { create(:bet, result: 'lose') }
  let(:return_bet) { create(:bet, result: 'return') }
  let(:pending_bet) { create(:bet, result: 'pending') }
  let!(:win_operation) { create(:operation, account: account, user: user, operational: win_bet) }
  let!(:lose_operation) { create(:operation, account: account, user: user, operational: lose_bet) }
  let!(:return_operation) { create(:operation, account: account, user: user, operational: return_bet) }
  let!(:pending_operation) { create(:operation, account: account, user: user, operational: pending_bet) }

  context 'when deposit operation' do
    it 'update final amount bet like win' do
      account_balance = account.balance
      described_class.new(win_bet).call
      account.reload
      expect(win_bet.winning_amount).to eq(win_bet.amount * win_bet.event.odds)
      expect(account.balance).to eq(account_balance + win_bet.winning_amount)
    end

    it 'update final amount bet like return' do
      account_balance = account.balance
      described_class.new(return_bet).call
      account.reload
      expect(return_bet.winning_amount).to eq(return_bet.amount)
      expect(account.balance).to eq(account_balance + return_bet.winning_amount)
    end
  end

  context 'when withdrawal operation' do
    it 'not update final amount with lose bet' do
      account_balance = account.balance
      described_class.new(lose_bet).call
      account.reload
      expect(lose_bet.winning_amount).to eq(0)
      expect(account.balance).to eq(account_balance)
    end

    it 'not update final amount with pending bet' do
      account_balance = account.balance
      described_class.new(pending_bet).call
      account.reload
      expect(pending_bet.winning_amount).to eq(0)
      expect(account.balance).to eq(account_balance)
    end
  end
end
