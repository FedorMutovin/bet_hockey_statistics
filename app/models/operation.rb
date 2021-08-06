class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :operational, polymorphic: true, touch: true

  after_create :change_account_balance!
  validate :check_balance

  def expense_transaction?
    operational.withdrawal?
  end

  private

  def change_account_balance!
    expense_transaction? ? withdraw! : deposit!
  end

  def deposit!
    account.update(balance: account.balance.to_f + operational.final_amount.to_f)
  end

  def withdraw!
    account.update(balance: account.balance - operational.amount)
  end

  def check_balance
    return unless expense_transaction?

    errors[:base] << 'Insufficient funds' if account.balance < operational.amount
  end
end
