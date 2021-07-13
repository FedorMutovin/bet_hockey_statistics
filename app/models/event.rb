class Event < ApplicationRecord
  include HasBookmaker
  EVENT_TYPES = %w[match_winner draw win].freeze

  has_many :bets, dependent: :destroy
  belongs_to :game
  belongs_to :team

  validates :odds, :name, presence: true
  validates :odds, format: { with: /\A\d+/, message: 'only digits' }
end
