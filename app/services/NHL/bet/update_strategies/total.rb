class NHL::Bet::UpdateStrategies::Total < NHL::Bet::UpdateStrategies
  private

  def update_bet!
    return bet.update(result: 'win') if score_array.sum.send(event.eventable.condition, event.eventable.value)
    return bet.update(result: 'return') if score_array.sum.eql?(event.eventable.value)

    bet.update(result: 'lose')
  end
end
