require 'rails_helper'

RSpec.describe RegularSeason, type: :model do
  it_behaves_like 'gameable'
  it_behaves_like 'has_season'
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
end
