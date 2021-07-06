class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :operational, polymorphic: true, touch: true

  after_create :change_account_balance!
  validate :check_balance

  private

  def change_account_balance!
    expense_transaction? ? withdraw! : deposit!
  end

  def deposit!
    account.update(balance: account.balance.to_f + operational.amount.to_f)
  end

  def withdraw!
    account.update(balance: account.balance.to_f - operational.amount.to_f)
  end

  def check_balance
    return unless expense_transaction?

    errors[:base] << 'Insufficient funds' if account.balance.to_f < operational.amount.to_f
  end

  def expense_transaction?
    operational_type.eql?('Bet') || operational.withdrawal?
  end
end
