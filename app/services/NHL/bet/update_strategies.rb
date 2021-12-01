class NHL::Bet::UpdateStrategies
  attr_reader :score_array, :winner_id, :event, :bet

  def initialize(event, bet, game)
    @event = event
    @bet = bet
    @game = game
    @score_array = @game.score.split(':').map(&:to_i)
    @winner_id = @game.winner_id
  end

  def self.call(event, bet, game)
    new(event, bet, game).call
  end

  def call
    update_bet!
    self
  end
end
