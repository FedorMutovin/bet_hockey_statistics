class OperationsController < ApplicationController
  before_action :operational, only: :show_operational

  def show_operational; end

  def create_operational; end

  private

  def operational
    @operational ||= Operation.find(params[:id])&.operational
  end
end
