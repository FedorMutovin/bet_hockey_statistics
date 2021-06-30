require 'rails_helper'

RSpec.describe NHL::Team::CreateService do
  subject(:team_create_service) { described_class.new('teams') }

  let!(:league) { create(:league) }

  it 'create teams' do
    expect { team_create_service.call }.to change(Team, :count).by(32)
  end
end
