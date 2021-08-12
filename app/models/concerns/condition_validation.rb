module ConditionValidation
  extend ActiveSupport::Concern
  DEFAULT_CONDITIONS = %w[< >].freeze

  included do
    validates :condition, inclusion: DEFAULT_CONDITIONS
    validates :condition, presence: true
  end
end
