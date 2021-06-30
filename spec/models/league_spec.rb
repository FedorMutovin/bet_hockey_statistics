require 'rails_helper'

RSpec.describe League, type: :model do
  it { is_expected.to have_many :seasons }
  it { is_expected.to have_many :teams }
  it { is_expected.to validate_presence_of :name }
end
