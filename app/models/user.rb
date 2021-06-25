class User < ApplicationRecord
  has_one :account, dependent: :destroy
  validates :mobile_phone, presence: true,
                           format: { with: /\d{11}/, message: 'must have 11 digits' },
                           uniqueness: { case_sensitive: false }
end
