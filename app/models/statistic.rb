class Statistic < ApplicationRecord
  belongs_to :team
  belongs_to :game
  validates :puck_holding_time, :attack_time, :attack_time_percentage,
            :total_shots, :total_shots_against, :shooting_percentage,
            :goals, :goals_against, :team_save_percentage, presence: true
  validates :game_id, uniqueness: { scope: :team_id, case_sensitive: false }
end
