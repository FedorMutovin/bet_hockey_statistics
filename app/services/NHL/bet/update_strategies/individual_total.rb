class NHL::Bet::UpdateStrategies::IndividualTotal < NHL::Bet::UpdateStrategies
  private

  def update_bet!
    if @game.extra_time.eql?(true)
      regulation_time_score = score_array.map { |_score| score_array.min }
      check_individual_total_result(regulation_time_score, event, bet)
    else
      check_individual_total_result(score_array, event, bet)
    end
  end

  def check_individual_total_result(score, event, bet)
    if event.team_id.eql?(@game.home_team_id)
      set_individual_total_result(score[0], event, bet)
    else
      set_individual_total_result(score[1], event, bet)
    end
  end

  def set_individual_total_result(score, event, bet)
    return bet.update(result: 'win') if score.send(event.eventable.condition, event.eventable.value)
    return bet.update(result: 'return') if score.eql?(event.eventable.value)

    bet.update(result: 'lose')
  end
end
