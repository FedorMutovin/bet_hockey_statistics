require 'rails_helper'

RSpec.describe Season, type: :model do
  it_behaves_like 'has_league'
  it { is_expected.to have_one :regular_season }
  it { is_expected.to have_one :playoff }
  it { is_expected.to validate_presence_of :year }
  it { is_expected.to allow_value('2020-21').for(:year) }
  it { is_expected.not_to allow_value('79').for(:year) }
  it { is_expected.not_to allow_value('220222').for(:year) }
  it { is_expected.not_to allow_value('220-222').for(:year) }

  describe 'validate year uniqness' do
    let!(:season) { create(:season) }

    it { is_expected.to validate_uniqueness_of(:year).case_insensitive }
  end
end
