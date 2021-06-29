class League < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :seasons, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
