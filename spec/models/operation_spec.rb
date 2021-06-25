require 'rails_helper'

RSpec.describe Operation, type: :model do
  it { is_expected.to belong_to(:operational) }
  it { is_expected.to belong_to(:account) }
  it { is_expected.to validate_presence_of :operational_id }
  it { is_expected.to validate_presence_of :operational_type }
end
