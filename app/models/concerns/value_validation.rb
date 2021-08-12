module ValueValidation
  extend ActiveSupport::Concern

  included do
    validates :value, presence: true
  end
end
