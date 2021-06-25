require 'rails_helper'

RSpec.describe Account, type: :model do
  it { is_expected.to have_many :operations }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :number }
  it { is_expected.to validate_uniqueness_of :number }
  it { is_expected.to validate_presence_of :balance }
end
