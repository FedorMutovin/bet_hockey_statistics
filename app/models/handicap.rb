class Handicap < ApplicationRecord
  include Eventable
  include ValueValidation

  def event
    value
  end
end
