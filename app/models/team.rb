class Team < ApplicationRecord
  include HasLeague
  has_many :games, foreign_key: :home_team_id, dependent: :destroy, inverse_of: :home_team
  has_many :games, foreign_key: :away_team_id, dependent: :destroy, inverse_of: :away_team
  has_many :events, dependent: :destroy
  validates :name, :abbreviation, presence: true
  validates :abbreviation, uniqueness: { scope: :name }, format: { with: /[A-Z]{3}/, message: 'AAA format' }
  before_validation :upcase_abbreviation

  private

  def upcase_abbreviation
    abbreviation&.upcase!
  end
end
