require 'rails_helper'

RSpec.shared_examples 'operational' do
  it { is_expected.to have_one(:operation).dependent(:destroy) }
end
