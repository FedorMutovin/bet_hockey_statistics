require 'rails_helper'

RSpec.describe Total, type: :model do
  it_behaves_like 'eventable'
  it_behaves_like 'validate_value'
  it_behaves_like 'validate_condition'
end
