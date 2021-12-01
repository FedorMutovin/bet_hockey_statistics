class NHL::Statistic::CreateService
  SAVE_PERCENTAGE_ROW_INDEX = 12
  SAVE_ABOUT_EXPECTED_ROW_INDEX = 3
  TEAM_TYPES = %w[home away].freeze

  def initialize(game, html)
    @game = game
    TEAM_TYPES.each do |type|
      instance_variable_set("@#{type}_xgoals", html.css("##{type}ScoreValueExpectedGoals").text)
      set_goalie_statistics(type, html)
    end
  end

  def call
    create_statistics!
    self
  end

  private

  def create_statistics!
    TEAM_TYPES.each do |type|
      @game.statistics.create(
        statisticable: @game.send("#{type}_team"),
        x_goals: instance_variable_get("@#{type}_xgoals"),
        x_goals_against: instance_variable_get("@#{against_team_type(type)}_xgoals"),
        save_percentage: instance_variable_get("@#{type}_save_percentage"),
        goals_saved_about_expected: instance_variable_get("@#{type}_save_about_expected")
      )
    end
  end

  def set_goalie_statistics(type, html)
    if html.css("##{type}TeamGoalieStats table tbody tr").count > 1
      build_save_percentage(calculate_goalie_statistics(html, type, SAVE_PERCENTAGE_ROW_INDEX), type)
      build_save_about_expected(calculate_goalie_statistics(html, type, SAVE_ABOUT_EXPECTED_ROW_INDEX), type)
    else
      build_save_percentage(html.css("##{type}TeamGoalieStats table tbody tr td")[SAVE_PERCENTAGE_ROW_INDEX].text, type)
      build_save_about_expected(html.css("##{type}TeamGoalieStats table tbody tr td")[SAVE_ABOUT_EXPECTED_ROW_INDEX]
                                  .text, type)
    end
  end

  def build_save_percentage(value, type)
    instance_variable_set("@#{type}_save_percentage", value)
  end

  def build_save_about_expected(value, type)
    instance_variable_set("@#{type}_save_about_expected", value)
  end

  def calculate_goalie_statistics(html, type, const)
    first_goalie_stat = html.css("##{type}TeamGoalieStats table tbody tr").first.css('td')[const].text
    second_goalie_stat = html.css("##{type}TeamGoalieStats table tbody tr").last.css('td')[const].text
    result = (first_goalie_stat.to_f + second_goalie_stat.to_f) / 2
    result.negative? ? result.ceil(2) : result.round(2)
  end

  def against_team_type(type)
    (TEAM_TYPES - [type]).first
  end
end
