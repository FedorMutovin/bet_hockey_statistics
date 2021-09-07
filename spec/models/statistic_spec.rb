require 'rails_helper'

RSpec.describe Statistic, type: :model do
  it { is_expected.to belong_to(:team) }
  it { is_expected.to belong_to(:game) }
  it { is_expected.to validate_presence_of :puck_holding_time }
  it { is_expected.to validate_presence_of :attack_time }
  it { is_expected.to validate_presence_of :attack_time_percentage }
  it { is_expected.to validate_presence_of :total_shots }
  it { is_expected.to validate_presence_of :total_shots_against }
  it { is_expected.to validate_presence_of :shooting_percentage }
  it { is_expected.to validate_presence_of :goals }
  it { is_expected.to validate_presence_of :goals_against }
end
