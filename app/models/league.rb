class League < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :seasons, dependent: :destroy
  validates :name, presence: true

  AVAILABLE_LEAGUES_NAMES = %w[NHL KHL].freeze
end
