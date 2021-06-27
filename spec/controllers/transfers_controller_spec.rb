require 'rails_helper'
require Rails.root.join 'spec/controllers/concerns/operated_spec'

RSpec.describe TransfersController, type: :controller do
  it_behaves_like 'operated' do
    let(:operational) { create(:transfer) }
    let!(:operation) { create(:operation, operational: operational) }
  end
end
