class Bet::ChangeWinningAmountService
  attr_reader :bet

  CALCULATION_STRATEGY = { 'win' => :calculate_win_amount, 'return' => :calculate_return_amount }.freeze

  def initialize(bet)
    @bet = bet
    @result = bet.result
  end

  def call
    change_winning_amount! if need_change_winning_amount?
    self
  end

  private

  def need_change_winning_amount?
    bet.deposit? && bet.winning_amount <= 0
  end

  def change_winning_amount!
    send CALCULATION_STRATEGY[bet.result]
    bet.operation.send(:change_account_balance!)
  end

  def calculate_win_amount
    bet.winning_amount += (bet.amount * bet.event.odds)
  end

  def calculate_return_amount
    bet.winning_amount += bet.amount
  end
end
