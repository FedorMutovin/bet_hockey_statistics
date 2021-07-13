class Event < ApplicationRecord
  include HasBookmaker
  has_many :bets, dependent: :destroy
  belongs_to :game

  validates :odds, :name, presence: true
  validates :name, uniqueness: true
end
