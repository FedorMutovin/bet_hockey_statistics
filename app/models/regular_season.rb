class RegularSeason < ApplicationRecord
  include Gameable
  include HasSeason
  validates :start_date, :end_date, presence: true
  validates :season_id, uniqueness: { scope: %i[start_date end_date], case_sensitive: false }
end
