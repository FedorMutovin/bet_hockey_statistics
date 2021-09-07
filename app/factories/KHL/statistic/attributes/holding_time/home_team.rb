class KHL::Statistic::Attributes::HoldingTime::HomeTeam < KHL::Statistic::Attributes::HoldingTimeFactory
  @holding_time_column_position = 2
  @attack_time_column_position = 4

  INDEX = {
    'puck_holding_time' => @holding_time_column_position,
    'attack_time' => @attack_time_column_position
  }.freeze
end
