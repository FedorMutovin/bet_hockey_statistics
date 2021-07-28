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
    operations.each do |operation|
      self.current_balance = balance_calculation(current_balance, operation)
      history[operation.created_at.to_date] = current_balance
    end
  end

  def balance_calculation(balance, operation)
    if operation.expense_transaction?
      balance -= operation.operational.amount
    else
      balance += operation.operational.amount
    end
    balance
  end
end
