require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it { is_expected.to have_one(:operation) }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_inclusion_of(:category).in_array(%w[deposit withdrawal]) }
  it { is_expected.to validate_presence_of :amount }
end
