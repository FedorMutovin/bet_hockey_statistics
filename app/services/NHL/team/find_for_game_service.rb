class NHL::Team::FindForGameService
  attr_accessor :id
  attr_reader :team_name

  NHL_TEAMS_NAMES = Team.nhl.pluck(:name, :id).to_h

  def initialize(team_name)
    @team_name = team_name
  end

  def call
    find_team_for_game
    self
  end

  private

  def find_team_for_game
    self.id = NHL_TEAMS_NAMES[team_name]
  end
end
