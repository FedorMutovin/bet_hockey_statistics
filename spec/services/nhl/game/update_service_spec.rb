require 'rails_helper'

RSpec.describe NHL::Game::UpdateService do
  subject(:game_update_service) { described_class.new }

  let!(:game) { create(:game, api_id: '2021020342', date: DateTime.current - 2.days) }
  let!(:game_with_extra_time) { create(:game, api_id: '2021020275', date: DateTime.current - 2.days) }

  it 'update game attributes' do
    game_update_service.call
    expect(game.reload.score).to eq('6:0')
    expect(game.winner_id).to eq(game.home_team_id)
    expect(game.extra_time).to be_falsey
    expect(game_with_extra_time.reload.score).to eq('5:4')
    expect(game_with_extra_time.winner_id).to eq(game_with_extra_time.home_team_id)
    expect(game_with_extra_time.extra_time).to be_truthy
  end
end
