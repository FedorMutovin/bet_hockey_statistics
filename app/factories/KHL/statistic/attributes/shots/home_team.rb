class KHL::Statistic::Attributes::Shots::HomeTeam < KHL::Statistic::Attributes::ShotsFactory
  @shots_column_position = 3
  @blocked_shots_column_position = -3

  INDEX = {
    'shots' => @shots_column_position,
    'blocked_shots' => @blocked_shots_column_position
  }.freeze
end
