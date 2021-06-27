require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it_behaves_like 'operational'
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_inclusion_of(:category).in_array(%w[deposit withdrawal]) }
  it { is_expected.to validate_presence_of :amount }
end
