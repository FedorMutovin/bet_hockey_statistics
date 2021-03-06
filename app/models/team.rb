class Team < ApplicationRecord
  include HasLeague
  include Statisticable
  has_many :games, foreign_key: :home_team_id, dependent: :destroy, inverse_of: :home_team
  has_many :games, foreign_key: :away_team_id, dependent: :destroy, inverse_of: :away_team
  has_many :games, foreign_key: :winner_id, dependent: :destroy, inverse_of: :winner
  validates :name, presence: true
  validates :abbreviation, uniqueness: { scope: :name },
                           format: { with: /[A-ZА-Я]{3}/, message: 'AAA format' },
                           if: -> { abbreviation.present? }
  before_validation :upcase_abbreviation

  private

  def upcase_abbreviation
    abbreviation&.upcase!
  end
end
