class Account < ApplicationRecord
  DEFAULT_BALANCE = 0
  before_validation :set_default_attributes, on: :create

  has_many :operations, dependent: :destroy
  belongs_to :bookmaker
  belongs_to :user

  validates :number, :balance, :bookmaker, presence: true
  validates :number, uniqueness: { case_sensitive: false }

  def balance_history
    Account::BalanceHistoryService.call(operations).history
  end

  private

  def set_default_attributes
    self.number = SecureRandom.hex(10)
    self.balance = DEFAULT_BALANCE if balance.nil? || balance.zero?
  end
end
