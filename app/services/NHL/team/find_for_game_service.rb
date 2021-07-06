class NHL::Team::FindForGameService
  attr_accessor :home_id, :away_id
  attr_reader :teams_params

  def initialize(teams_params)
    @teams_params = teams_params
  end

  def call
    find_teams_for_game
    self
  end

  private

  def find_teams_for_game
    home_team
    away_team
  end

  def home_team
    @home_id = Team.find_by(name: home_team_name).id
  end

  def away_team
    @away_id = Team.find_by(name: away_team_name).id
  end

  def away_team_name
    teams_params['away']['team']['name']
  end

  def home_team_name
    teams_params['home']['team']['name']
  end
end
