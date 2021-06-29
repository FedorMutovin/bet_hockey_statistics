require 'rails_helper'

RSpec.shared_examples 'has_bookmaker' do
  it { is_expected.to belong_to :bookmaker }
end
