class NHL::Bet::UpdateStrategies::MatchWinner < NHL::Bet::UpdateStrategies
  private

  def update_bet!
    if @game.extra_time?
      event.eventable.with_extra_time? ? set_match_winner_result(event, bet) : bet.update(result: 'lose')
    else
      set_match_winner_result(event, bet)
    end
  end

  def set_match_winner_result(event, bet)
    @game.winner_id.eql?(event.team_id) ? bet.update(result: 'win') : bet.update(result: 'lose')
  end
end
