class Bet < ApplicationRecord
  has_one :operation, dependent: :destroy, as: :operational
  validates :result, :odds, :event, :league, :home_team, :away_team, :match_date, presence: true
  validates :result, inclusion: %w[win lose return pending]

  scope :win, -> { where(category: 'win') }
  scope :lose, -> { where(category: 'lose') }
  scope :return, -> { where(category: 'return') }
  scope :pending, -> { where(category: 'pending') }
end
