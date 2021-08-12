require 'rails_helper'

RSpec.shared_examples 'validate_condition' do
  it { is_expected.to validate_presence_of :condition }
  it { is_expected.to validate_inclusion_of(:condition).in_array(%w[< >]) }
end
