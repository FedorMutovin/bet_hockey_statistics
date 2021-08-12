require 'rails_helper'

RSpec.describe NHL::Season::CreateService do
  subject(:season_create_service) { described_class.new('seasons') }

  let!(:league) { create(:league, :nhl) }

  it 'create season regular_season playoff' do
    expect { season_create_service.call }.to change(Season, :count).by(1)
  end
end
