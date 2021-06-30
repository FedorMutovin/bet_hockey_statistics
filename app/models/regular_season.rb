class RegularSeason < ApplicationRecord
  include Gameable
  include HasSeason
  validates :start_date, :end_date, presence: true
end
