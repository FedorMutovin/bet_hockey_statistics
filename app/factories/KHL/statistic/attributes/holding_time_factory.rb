class KHL::Statistic::Attributes::HoldingTimeFactory < KHL::Statistic::AttributesFactory
  HOURS_FOR_TIME_CONVERTING = '00:'.freeze
  PUCK_HOLDING_TIME_BLOCK_INDEX = -1
  ATTACK_TIME_BLOCK_INDEX = -2

  private

  def convert_time_to_seconds_format(time)
    converted_time = Time.zone.parse(HOURS_FOR_TIME_CONVERTING + time)
    converted_time.min * 60 + converted_time.sec
  end
end
