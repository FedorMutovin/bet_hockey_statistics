class Account::BalanceHistoryService
  attr_accessor :history, :current_balance
  attr_reader :operations

  def initialize(operations)
    @operations = operations
    @history = {}
    @current_balance = 0
  end

  def self.call(args)
    new(args).call
  end

  def call
    check_history
    self
  end

  private

  def check_history
    operations.includes(:operational).each do |operation|
      self.current_balance = balance_calculation(current_balance, operation)
      history[operation.created_at.to_date] = current_balance.to_i
    end
  end

  def balance_calculation(balance, operation)
    if operation.expense_transaction?
      balance -= operation.operational.amount
    else
      balance += operation.operational_type.eql?('Transfer') ? operation.operational.amount : bet_win(operation)
    end
    balance
  end

  def bet_win(operation)
    operation.operational.final_amount - operation.operational.amount
  end
end
