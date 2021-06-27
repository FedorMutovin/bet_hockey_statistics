require 'rails_helper'

RSpec.describe Bet, type: :model do
  it_behaves_like 'operational'
  it { is_expected.to validate_presence_of :result }
  it { is_expected.to validate_inclusion_of(:result).in_array(%w[win lose return pending]) }
  it { is_expected.to validate_presence_of :odds }
  it { is_expected.to validate_presence_of :event }
  it { is_expected.to validate_presence_of :league }
  it { is_expected.to validate_presence_of :home_team }
  it { is_expected.to validate_presence_of :away_team }
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_presence_of :match_date }
end
