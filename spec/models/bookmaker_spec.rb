require 'rails_helper'

RSpec.describe Bookmaker, type: :model do
  it { is_expected.to have_many :accounts }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :country }

  describe 'validate name uniqness' do
    let!(:bookmaker) { create(:bookmaker) }

    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
end
