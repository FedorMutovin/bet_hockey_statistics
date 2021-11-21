class Game < ApplicationRecord
  include HasLeague
  include HasSeason
  has_many :events, dependent: :destroy
  has_many :statistics, dependent: :destroy
  belongs_to :gameable, polymorphic: true, touch: true
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :winner, class_name: 'Team', optional: true

  validates :date, presence: true
  validates :date, uniqueness: { scope: %i[home_team_id away_team_id], case_sensitive: false }

  scope :coming, -> { where('date >= ? and score is null', DateTime.current) }

  TEAMS_TYPES = %w[home_team away_team].freeze

  def name_for_bet
    "#{home_team.name} - #{away_team.name} #{date.to_formatted_s(:long)}"
  end
end
