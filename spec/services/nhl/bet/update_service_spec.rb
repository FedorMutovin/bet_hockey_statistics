require 'rails_helper'

RSpec.describe NHL::Bet::UpdateService do
  subject(:bet_update_service) { described_class.new(game) }

  let(:account) { create(:account) }
  let(:team) { create(:team) }
  let(:match_winner) { create(:match_winner, with_extra_time: false) }
  let(:handicap) { create(:handicap) }
  let(:game) { create(:game, home_team: team, winner: team, score: '5:4') }
  let(:match_winner_event) { create(:event, game: game, team: team, eventable: match_winner) }
  let(:handicap_event) { create(:event, game: game, team: team, eventable: handicap) }
  let(:match_winner_bet) { create(:bet, event: match_winner_event) }
  let(:handicap_bet) { create(:bet, event: handicap_event) }
  let!(:handicap_bet_operation) do
    create(:operation, operational: handicap_bet, account: account,
                       user: account.user)
  end
  let!(:match_winner_bet_operation) do
    create(:operation, operational: match_winner_bet, account: account,
                       user: account.user)
  end

  it 'update bet result' do
    bet_update_service.call
    expect(match_winner_bet.reload.result).to eq('win')
    expect(handicap_bet.reload.result).to eq('lose')
  end
end
