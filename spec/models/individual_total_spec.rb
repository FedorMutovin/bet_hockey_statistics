require 'rails_helper'

RSpec.describe IndividualTotal, type: :model do
  it_behaves_like 'eventable'
  it_behaves_like 'validate_value'
  it_behaves_like 'validate_condition'
end
