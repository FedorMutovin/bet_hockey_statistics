require 'rails_helper'

RSpec.shared_examples 'gameable' do
  it { is_expected.to have_many(:games).dependent(:destroy) }
end
