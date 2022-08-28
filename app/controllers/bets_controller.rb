class BetsController < ApplicationController
  before_action :user, only: :search_data
  before_action :teams, :games, only: :search_data, if: -> { params[:league_name].present? }
  include Operated

  def search_data; end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def teams
    @teams ||= Team.all
  end

  def games
    @games ||= Game.includes(%i[home_team away_team]).coming.order(date: :asc)
  end

  def bet_params
    params.require(:bet).permit(:amount, :tax,
                                event_attributes: %i[game_id eventable_id eventable_type odds team_id bookmaker_id],
                                operation_attributes: %i[account_id user_id])
  end
end
