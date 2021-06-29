require 'rails_helper'

RSpec.describe Team, type: :model do
  let!(:game) { create(:game) }

  it_behaves_like 'has_league'
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :abbreviation }
  it { is_expected.to allow_value('AAA').for(:abbreviation) }
  it { is_expected.to have_many(:games).dependent(:destroy) }
  it { is_expected.to have_many(:games).dependent(:destroy).with_foreign_key('away_team_id') }

  describe 'validate abbreviation uniqness' do
    let!(:game) { create(:game) }

    it { is_expected.to validate_uniqueness_of(:abbreviation).scoped_to(:name).case_insensitive }
  end

  describe '.upcase_abbreviation' do
    let!(:team) { create(:team, abbreviation: 'aaa') }

    it 'upcase abbreviation' do
      expect(team.abbreviation).to eq 'AAA'
    end
  end
end
