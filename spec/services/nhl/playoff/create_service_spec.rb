require 'rails_helper'

RSpec.describe NHL::Playoff::CreateService do
  subject(:playoff_create_service) { described_class.new(create(:season).id) }

  it 'create playoff' do
    expect { playoff_create_service.call }.to change(Playoff, :count).by(2)
  end
end
