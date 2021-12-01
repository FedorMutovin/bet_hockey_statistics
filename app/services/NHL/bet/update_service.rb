class NHL::Bet::UpdateService
  attr_reader :score_array, :winner_id

  BET_RESULT_CALCULATION_STRATEGIES = {
    'MatchWinner' => :match_winner_strategy,
    'Handicap' => :handicap_strategy,
    'IndividualTotal' => :individual_total_strategy,
    'Total' => :total_strategy
  }.freeze

  def initialize(game)
    @game = game
  end

  def call
    update_bets_result!
    self
  end

  BET_RESULT_CALCULATION_STRATEGIES.each_key do |strategy|
    define_method "#{strategy.underscore}_strategy" do |event, bet|
      "NHL::Bet::UpdateStrategies::#{strategy}".constantize.call(event, bet, @game)
    end
  end

  private

  def update_bets_result!
    @game.events.each do |event|
      event.bets.each do |bet|
        next unless bet.result.eql?('pending')

        send(BET_RESULT_CALCULATION_STRATEGIES[event.eventable_type], event, bet)
      end
    end
  end
end
