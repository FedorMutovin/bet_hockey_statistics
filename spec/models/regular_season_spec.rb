require 'rails_helper'

RSpec.describe RegularSeason, type: :model do
  it_behaves_like 'gameable'
  it { is_expected.to belong_to(:season) }
end
