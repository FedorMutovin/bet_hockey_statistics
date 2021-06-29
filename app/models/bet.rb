class Bet < ApplicationRecord
  include Operational
  belongs_to :event

  validates :result, :amount, presence: true
  validates :result, inclusion: %w[win lose return pending]

  scope :win, -> { where(category: 'win') }
  scope :lose, -> { where(category: 'lose') }
  scope :return, -> { where(category: 'return') }
  scope :pending, -> { where(category: 'pending') }
end
