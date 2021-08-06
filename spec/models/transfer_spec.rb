require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it_behaves_like 'operational'
  it { is_expected.to validate_presence_of :result }
  it { is_expected.to validate_inclusion_of(:result).in_array(%w[deposit withdrawal]) }
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to allow_value(100.5).for(:amount) }
end
