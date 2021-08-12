require 'rails_helper'

RSpec.describe KHL::Team::CreateService do
  subject(:season_create_service) { described_class.new('teams') }

  let!(:league) { create(:league, name: 'KHL') }

  it 'create season regular_season playoff' do
    expect { season_create_service.call }.to change(Team, :count).by(24)
  end
end
