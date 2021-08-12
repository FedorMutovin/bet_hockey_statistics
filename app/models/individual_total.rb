class IndividualTotal < ApplicationRecord
  include Eventable
  include ValueValidation
  include ConditionValidation

  def event
    "#{condition} #{value}"
  end
end
