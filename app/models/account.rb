class Account < ApplicationRecord
  include HasBookmaker
  has_many :operations, dependent: :destroy
  belongs_to :user
  validates :number, :balance, :bookmaker, presence: true
  validates :number, uniqueness: { case_sensitive: false }

  delegate :name, to: :bookmaker, prefix: true
end
