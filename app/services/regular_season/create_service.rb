class RegularSeason::CreateService
  attr_reader :season_id, :start_date, :end_date

  def initialize(season_id, start_date, end_date)
    @season_id = season_id
    @start_date = start_date
    @end_date = end_date
  end

  def call
    create_regular_season!
    self
  end

  private

  def create_regular_season!
    RegularSeason.create!(
      start_date: start_date,
      end_date: end_date,
      season_id: season_id
    )
  end
end
