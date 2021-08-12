require 'rails_helper'

RSpec.shared_examples 'validate_value' do
  it { is_expected.to validate_presence_of :value }
end
