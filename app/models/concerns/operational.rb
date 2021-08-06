module Operational
  extend ActiveSupport::Concern

  included do
    has_one :operation, dependent: :destroy, as: :operational

    after_update :update_operation_updated_at!
  end

  private

  def update_operation_updated_at!
    operation.update(updated_at: Time.zone.now)
  end
end
