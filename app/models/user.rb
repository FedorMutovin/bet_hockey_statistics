class User < ApplicationRecord
  has_many :accounts, dependent: :destroy
  has_many :operations, dependent: :destroy
  validates :mobile_phone, presence: true,
                           format: { with: /\d{11}/, message: 'must have 11 digits' },
                           uniqueness: { case_sensitive: false }

  def overall_balance
    accounts.pluck(:balance).map(&:to_i).sum
  end
end
