class KHL::Statistic::CreateService
  def initialize(game, params)
    @game = game
    @params = params
    @score = game.score.split(':')
  end

  def call
    create_statistics!
  end

  private

  def create_statistics!
    build_statistics
    Game::TEAMS_TYPES.each do |team_type|
      Statistic.create!(@statistic.instance_variable_get("@#{team_type}"))
    end
    self
  end

  def build_statistics
    @statistic = KHL::StatisticFactory.new(@game, @params, @score).create
  end
end
