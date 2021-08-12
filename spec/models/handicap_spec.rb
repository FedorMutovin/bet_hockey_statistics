require 'rails_helper'

RSpec.describe Handicap, type: :model do
  it_behaves_like 'eventable'
  it_behaves_like 'validate_value'
end
