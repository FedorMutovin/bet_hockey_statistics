require 'rails_helper'

RSpec.describe Bet, type: :model do
  it_behaves_like 'operational'
  it { is_expected.to belong_to(:event) }
  it { is_expected.to validate_presence_of :result }
  it { is_expected.to validate_inclusion_of(:result).in_array(%w[win lose return pending]) }
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to allow_value('79000000000').for(:amount) }
  it { is_expected.not_to allow_value('s9').for(:amount) }
end
