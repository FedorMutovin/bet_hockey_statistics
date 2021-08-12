require 'rails_helper'

RSpec.describe Game, type: :model do
  it_behaves_like 'has_season'
  it_behaves_like 'has_league'
  it { is_expected.to belong_to(:gameable) }
  it { is_expected.to have_many :events }
  it { belong_to :home_team }
  it { belong_to :away_team }
  it { is_expected.to validate_presence_of :date }

  describe 'validate data uniqness' do
    let!(:game) { create(:game, :nhl) }

    it { is_expected.to validate_uniqueness_of(:date).scoped_to(%i[home_team_id away_team_id]).case_insensitive }
  end
end
