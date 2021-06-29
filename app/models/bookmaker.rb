class Bookmaker < ApplicationRecord
  has_many :accounts, dependent: :destroy
  validates :name, :country, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
