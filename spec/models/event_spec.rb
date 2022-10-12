require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to(:eventable) }
  it { is_expected.to belong_to(:game) }
  it { is_expected.to belong_to(:team).optional }
  it { is_expected.to have_many(:bets) }
  it { is_expected.to validate_presence_of :odds }
end
