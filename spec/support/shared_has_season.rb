require 'rails_helper'

RSpec.shared_examples 'has_season' do
  it { is_expected.to belong_to :season }
end
