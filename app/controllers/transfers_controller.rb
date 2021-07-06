class TransfersController < ApplicationController
  include Operated

  private

  def transfer_params
    params.require(:transfer).permit(:category, :amount, operation_attributes: %i[account_id user_id])
  end
end
