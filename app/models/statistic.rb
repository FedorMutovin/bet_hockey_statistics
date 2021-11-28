class Statistic < ApplicationRecord
  belongs_to :game
  belongs_to :statisticable, polymorphic: true, touch: true
  validates :game_id, uniqueness: { scope: :statisticable_id, case_sensitive: false }
end
