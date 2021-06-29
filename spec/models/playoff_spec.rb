require 'rails_helper'

RSpec.describe Playoff, type: :model do
  it_behaves_like 'gameable'
  it_behaves_like 'has_season'
end
