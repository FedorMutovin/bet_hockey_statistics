require 'rails_helper'

RSpec.shared_examples 'eventable' do
  it { is_expected.to have_many(:events).dependent(:destroy) }
end
