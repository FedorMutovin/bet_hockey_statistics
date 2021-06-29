class Event < ApplicationRecord
  include HasBookmaker
  belongs_to :game

  validates :odds, :name, presence: true
  validates :name, uniqueness: true
end
