require 'rails_helper'

RSpec.shared_examples 'has_league' do
  it { is_expected.to belong_to :league }
end
