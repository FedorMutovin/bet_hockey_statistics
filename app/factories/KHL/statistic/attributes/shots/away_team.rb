class KHL::Statistic::Attributes::Shots::AwayTeam < KHL::Statistic::Attributes::ShotsFactory
  @shots_column_position = -2
  @blocked_shots_column_position = 2

  INDEX = {
    'shots' => @shots_column_position,
    'blocked_shots' => @blocked_shots_column_position
  }.freeze
end
