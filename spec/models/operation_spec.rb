require 'rails_helper'

RSpec.describe Operation, type: :model do
  it { is_expected.to belong_to(:operational) }
  it { is_expected.to belong_to(:account) }
end
