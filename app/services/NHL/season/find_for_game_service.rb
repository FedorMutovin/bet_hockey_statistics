class NHL::Season::FindForGameService
  attr_reader :season_params
  attr_accessor :season

  def initialize(season_params)
    @season_params = season_params
  end

  def call
    find_season
    self
  end

  private

  def find_season
    @season = Season.find_by(year: season_params)
  end
end
