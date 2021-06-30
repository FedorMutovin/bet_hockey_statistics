class Season < ApplicationRecord
  include HasLeague
  has_one :regular_season, dependent: :destroy
  has_one :playoff, dependent: :destroy
  validates :year, presence: true, uniqueness: { case_sensitive: false },
                   format: { with: /\A\d{8}/, message: 'yyyyyyyy format' }
  after_create :set_playoff

  def with_regular_season(start_date, end_date)
    set_regular_season(start_date, end_date)
  end

  private

  def set_regular_season(start_date, end_date)
    league_name::RegularSeason::CreateService.new(id, start_date, end_date).call
  end

  def set_playoff
    league_name::Playoff::CreateService.new(id).call
  end

  def league_name
    league.name.constantize
  end
end
