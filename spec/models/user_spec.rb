require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_one :account }
  it { is_expected.to validate_presence_of :mobile_phone }
  it { is_expected.to allow_value('79000000000').for(:mobile_phone) }
  it { is_expected.not_to allow_value('79').for(:mobile_phone) }

  describe 'validate mobile phone uniqness' do
    let!(:user) { create(:user) }

    it { is_expected.to validate_uniqueness_of(:mobile_phone).case_insensitive }
  end
end
