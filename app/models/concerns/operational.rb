module Operational
  extend ActiveSupport::Concern

  included do
    has_one :operation, dependent: :destroy, as: :operational
  end
end
