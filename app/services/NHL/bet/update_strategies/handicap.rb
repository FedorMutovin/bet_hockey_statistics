class NHL::Bet::UpdateStrategies::Handicap < NHL::Bet::UpdateStrategies
  private

  def update_bet!
    return extra_time_handicap_result(event, bet) if @game.extra_time.eql?(true)

    if event.eventable.value.negative?
      return set_negative_handicap_result(event, bet) if winner_id.eql?(event.team_id)

      bet.update(result: 'lose')
    elsif event.eventable.value.positive?
      return bet.update(result: 'win') if winner_id.eql?(event.team_id)

      check_handicap_for_team_result(event, bet)
    else
      zero_handicap_result(event, bet)
    end
  end

  def extra_time_handicap_result(event, bet)
    bet.update(result: 'lose') if event.eventable.value.negative?
    bet.update(result: 'win') if event.eventable.value.positive?
    bet.update(result: 'return') if event.eventable.value.zero?
  end

  def set_negative_handicap_result(event, bet)
    if (score_array.max - score_array.min) > event.eventable.value.abs
      bet.update(result: 'win')
    else
      bet.update(result: 'lose')
    end
  end

  def check_handicap_for_team_result(event, bet)
    if event.team_id.eql?(@game.home_team_id)
      set_positive_handicap_result(score_array[0], score_array[1], event, bet)
    else
      set_positive_handicap_result(score_array[1], score_array[0], event, bet)
    end
  end

  def set_positive_handicap_result(first_score, second_score, event, bet)
    bet.update(result: 'win') if (first_score - second_score + event.eventable.value).positive?
    bet.update(result: 'return') if (first_score - second_score + event.eventable.value).zero?
    bet.update(result: 'lose') if (first_score - second_score + event.eventable.value).negative?
  end

  def zero_handicap_result(event, bet)
    return bet.update(result: 'win') if winner_id.eql?(event.team_id)

    bet.update(result: 'lose')
  end
end
