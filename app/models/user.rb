class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :accounts, dependent: :destroy
  has_many :operations, dependent: :destroy
  validates :mobile_phone, presence: true,
                           format: { with: /\d{11}/, message: 'must have 11 digits' },
                           uniqueness: { case_sensitive: false }

  def overall_balance
    accounts.pluck(:balance).map(&:to_i).sum
  end

  def accounts_balance_history
    history = {}
    accounts.each do |account|
      history.merge!(Account::BalanceHistoryService.call(account.operations).history)
    end
    history.sort.to_h
  end
end
