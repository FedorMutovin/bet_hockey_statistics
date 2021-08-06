require 'rails_helper'

RSpec.describe RegularSeason, type: :model do
  it_behaves_like 'gameable'
  it_behaves_like 'has_season'
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }

  describe 'validate league_id uniqness' do
    let!(:regular_season) { create(:regular_season) }

    it { is_expected.to validate_uniqueness_of(:season_id).scoped_to(%i[start_date end_date]).case_insensitive }
  end
end
