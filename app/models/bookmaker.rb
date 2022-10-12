class Bookmaker < ApplicationRecord
  has_many :accounts, dependent: :destroy
  validates :name, :country, :country_tax_percentage, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :country_tax_percentage, numericality: { less_than: 1 }
end
