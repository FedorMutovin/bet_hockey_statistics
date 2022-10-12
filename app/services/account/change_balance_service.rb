class Account::ChangeBalanceService
  attr_accessor :account, :operational

  def initialize(account, operational)
    @account = account
    @operational = operational
  end

  def call
    change_balance!
    self
  end

  private

  def change_balance!
    account.lock!
    account.reload
    operational.withdrawal? ? withdraw! : deposit!
  end

  def deposit!
    account.update(balance: account.balance.to_f + operational.final_amount.to_f)
  end

  def withdraw!
    account.update(balance: account.balance - operational.amount)
  end
end
