require 'rails_helper'
require Rails.root.join 'spec/controllers/concerns/operated_spec'

RSpec.describe TransfersController, type: :controller do
  it_behaves_like 'operated' do
    let(:user) { create(:user) }
    let(:account) { create(:account, user: user) }
    let(:operational) { create(:transfer) }
    let!(:operation) { create(:operation, operational: operational, account: account, user: user) }
  end
end
