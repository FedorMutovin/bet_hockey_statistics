require 'rails_helper'

RSpec.describe Account, type: :model do
  it_behaves_like 'has_bookmaker'
  it { is_expected.to have_many :operations }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :bookmaker }
  it { is_expected.to validate_presence_of :number }
  it { is_expected.to validate_presence_of :balance }

  describe 'validate number uniqness' do
    let!(:account) { create(:account) }

    it { is_expected.to validate_uniqueness_of(:number).case_insensitive }
  end
end
