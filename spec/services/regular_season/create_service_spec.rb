require 'rails_helper'

RSpec.describe RegularSeason::CreateService do
  subject(:regular_season_create_service) do
    described_class.new(create(:season).id,
                        Date.current - 3.months,
                        Date.current - 1.month)
  end

  it 'create playoff' do
    expect { regular_season_create_service.call }.to change(RegularSeason, :count).by(1)
  end
end
