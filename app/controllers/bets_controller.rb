class BetsController < ApplicationController
  include Operated

  private

  def bet_params
    params.require(:bet).permit(:amount,
                                event_attributes: %i[game_id name odds team_id bookmaker_id],
                                operation_attributes: %i[account_id user_id])
  end
end
