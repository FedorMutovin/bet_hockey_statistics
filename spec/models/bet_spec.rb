require 'rails_helper'

RSpec.describe Bet, type: :model do
  it_behaves_like 'operational'
  it { is_expected.to belong_to(:event) }
  it { is_expected.to validate_presence_of :result }
  it { is_expected.to validate_inclusion_of(:result).in_array(%w[win lose return pending]) }
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_presence_of :final_amount }
  it { is_expected.to allow_value(100.5).for(:amount) }

  describe 'it change account balance after change result' do
    let(:user) { create(:user) }
    let(:account) { create(:account, user: user) }
    let(:bet) { create(:bet) }
    let!(:operation) { create(:operation, account: account, user: user, operational: bet) }

    it 'true if result win' do
      account_balance = account.balance
      bet.update(result: 'win')
      expect(bet.final_amount).to be > 0
      account.reload
      expect(account.balance).to eq(account_balance + bet.final_amount)
    end

    it 'false if result lose' do
      account_balance = account.balance
      bet.update(result: 'lose')
      expect(bet.final_amount).to be 0.0
      account.reload
      expect(account.balance).to eq(account_balance)
    end

    it 'false if bet updated and status pending' do
      account_balance = account.balance
      bet.update(updated_at: Time.zone.now)
      account.reload
      expect(account.balance).to eq(account_balance)
    end
  end
end
