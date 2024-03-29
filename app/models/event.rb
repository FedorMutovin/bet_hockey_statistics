class Event < ApplicationRecord
  AVAILABLE_EVENTS = %w[MatchWinner Handicap IndividualTotal Total].freeze

  has_many :bets, dependent: :destroy
  belongs_to :game
  belongs_to :team, optional: true
  belongs_to :eventable, polymorphic: true, touch: true

  validates :odds, presence: true
  validates :odds, format: { with: /\A\d+/, message: 'only digits' }
end
