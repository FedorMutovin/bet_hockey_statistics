class Event < ApplicationRecord
  include HasBookmaker
  belongs_to :game

  validates :odds, presence: true
end
