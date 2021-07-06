module Operated
  extend ActiveSupport::Concern

  included do
    before_action :operational, only: :show
  end

  def show; end

  def create
    @operational = create_operation!.operational
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def operational
    @operational = model_klass.find(params[:id])
  end

  def create_operation!
    Operation::CreateService.new(model_klass, send("#{model_klass.name.downcase}_params")).call
  end
end
