class TransfersController < ApplicationController
  include Operated

  private

  def transfer_params
    params.require(:transfer).permit(:result, :amount, operation_attributes: %i[account_id user_id])
  end
end
