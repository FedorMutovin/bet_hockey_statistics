class Bet::ChangeFinalAmountService
  attr_reader :bet

  CALCULATION_STRATEGY = { 'win' => :calculate_win_amount, 'return' => :calculate_return_amount }.freeze

  def initialize(bet)
    @bet = bet
    @result = bet.result
  end

  def call
    change_final_amount! if need_change_final_amount?
    self
  end

  private

  def need_change_final_amount?
    bet.deposit? && bet.final_amount <= 0
  end

  def change_final_amount!
    send CALCULATION_STRATEGY[bet.result]
    bet.operation.send(:change_account_balance!)
  end

  def calculate_win_amount
    bet.final_amount += (bet.amount * bet.event.odds)
  end

  def calculate_return_amount
    bet.final_amount += bet.amount
  end
end
