class BetsController < ApplicationController
  include Operated

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def bet_params
    params.require(:bet).permit(:amount,
                                event_attributes: %i[game_id eventable_id eventable_type odds team_id bookmaker_id],
                                operation_attributes: %i[account_id user_id])
  end
end
