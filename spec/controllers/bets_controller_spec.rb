require 'rails_helper'
require Rails.root.join 'spec/controllers/concerns/operated_spec'

RSpec.describe BetsController, type: :controller do
  it_behaves_like 'operated' do
    let(:operational) { create(:bet) }
    let!(:operation) { create(:operation, operational: operational) }
  end
end
