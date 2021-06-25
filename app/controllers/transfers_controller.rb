class TransfersController < ApplicationController
  before_action :transfer, only: :show

  def show; end

  private

  def transfer
    @transfer ||= Transfer.find(params[:id])
  end
end
