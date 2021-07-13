require 'rails_helper'

RSpec.describe Event, type: :model do
  it_behaves_like 'has_bookmaker'
  it { is_expected.to belong_to(:game) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to have_many(:bets) }
  it { is_expected.to validate_presence_of :odds }
  it { is_expected.to validate_presence_of :name }
end
