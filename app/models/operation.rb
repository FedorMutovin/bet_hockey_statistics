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
    Account::ChangeBalanceService.new(account, operational).call
  end

  def check_balance
    return unless expense_transaction?

    errors.add(:base, :insufficient_funds, message: 'Insufficient funds') if account.balance < operational.amount
  end
end
