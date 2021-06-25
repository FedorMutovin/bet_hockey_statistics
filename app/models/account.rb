class Account < ApplicationRecord
  belongs_to :user
  has_many :operations, dependent: :destroy
  validates :number, :balance, presence: true
  validates :number, uniqueness: true
end
