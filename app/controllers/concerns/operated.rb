module Operated
  extend ActiveSupport::Concern

  included do
    before_action :set_operational, only: :show
  end

  def show; end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_operational
    @operational = model_klass.find(params[:id])
  end
end
