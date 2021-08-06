class Playoff::CreateService
  attr_reader :season_id

  def initialize(season_id)
    @season_id = season_id
  end

  def call
    create_playoff!
    self
  end

  private

  def create_playoff!
    Playoff.create(season_id: season_id)
  end
end
