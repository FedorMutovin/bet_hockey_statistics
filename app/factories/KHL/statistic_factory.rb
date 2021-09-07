class KHL::StatisticFactory
  attr_accessor :home_team, :away_team

  ATTRIBUTES_FACTORIES_WITH_METHODS = {
    'HoldingTime' => %w[puck_holding_time attack_time],
    'Shots' => %w[shots blocked_shots]
  }.freeze

  DEFAULT_SAVE_PERCENTAGE = 100
  DEFAULT_ATTRIBUTES = %w[created_at updated_at id].freeze
  NOT_CALCULATED_ATTRIBUTES = %w[total_shots_against].freeze

  STATISTIC_ATTRIBUTES = Statistic.attribute_names - DEFAULT_ATTRIBUTES - NOT_CALCULATED_ATTRIBUTES

  def initialize(game, params, score)
    @game = game
    @params = params
    @score = score
    Game::TEAMS_TYPES.each do |team_type|
      instance_variable_set("@#{team_type}", {})
    end
  end

  def create
    create_statistics_attributes
    fill_against_shots
    self
  end

  private

  def create_statistics_attributes
    Game::TEAMS_TYPES.each do |team_type|
      @team_type = team_type
      build_attributes_from_factory(team_type)
      build_attributes(team_type)
    end
  end

  def fill_against_shots
    Game::TEAMS_TYPES.each do |team_type|
      against_team_type = team_type.eql?('home_team') ? 'away_team' : 'home_team'
      instance_variable_get("@#{team_type}")['total_shots_against'] =
        instance_variable_get("@#{against_team_type}")['total_shots']
    end
  end

  def build_attributes_from_factory(team_type)
    ATTRIBUTES_FACTORIES_WITH_METHODS.each do |factory_name, methods|
      methods.each do |method_name|
        instance_variable_set("@#{method_name}",
                              "KHL::Statistic::Attributes::#{factory_name}::#{team_type.camelize}"
                                .constantize
                                .new(method_name, @params)
                                .create)
        build_get_methods(method_name)
      end
    end
  end

  def build_attributes(team_type)
    STATISTIC_ATTRIBUTES.each do |attr|
      instance_variable_get("@#{team_type}")[attr] = send(attr)
    end
  end

  def build_get_methods(method_name)
    self.class.define_method(method_name) do
      instance_variable_get("@#{method_name}")
    end
  end

  def goals
    @team_type.eql?('home_team') ? @score.first : @score.last
  end

  def goals_against
    @team_type.eql?('home_team') ? @score.last : @score.first
  end

  def game_id
    @game.id
  end

  def team_id
    @game.send(@team_type).id
  end

  def attack_time_percentage
    (@attack_time.to_f / @puck_holding_time * 100).round(2)
  end

  def team_save_percentage
    DEFAULT_SAVE_PERCENTAGE - (goals_against.to_f / total_shots * 100).round(2)
  end

  def shooting_percentage
    (goals.to_f / total_shots * 100).round(2)
  end

  def total_shots
    @shots + @blocked_shots
  end
end
