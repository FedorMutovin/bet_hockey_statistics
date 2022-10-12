require 'rails_helper'

RSpec.describe Account, type: :model do
  it { is_expected.to have_many :operations }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :bookmaker }

  describe 'set_default_attributes' do
    let!(:account) { create(:account, balance: nil) }

    it 'has default number and balance' do
      expect(account.number).to be_present
      expect(account.balance).to eq(0)
    end
  end
end
