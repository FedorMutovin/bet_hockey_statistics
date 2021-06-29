class Game < ApplicationRecord
  include HasLeague
  include HasSeason
  belongs_to :gameable, polymorphic: true, touch: true
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  validates :date, :score, presence: true
  validates :date, uniqueness: { scope: %i[home_team_id away_team_id], case_sensitive: false }
end
