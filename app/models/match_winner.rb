class MatchWinner < ApplicationRecord
  include Eventable

  def event
    "with_extra_time: #{with_extra_time}"
  end
end
