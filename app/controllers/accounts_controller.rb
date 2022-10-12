class AccountsController < ApplicationController
  before_action :account, only: %i[show destroy]
  before_action :teams, :games, only: :show

  def show
    @operations = @account.operations.includes(:operational).order(created_at: :desc).limit(5)
  end

  def create
    account = current_user.accounts.new(account_params)
    if account.save
      redirect_to root_path, notice: 'Your account successfully created.'
    else
      render root_path
    end
  end

  def destroy
    if @account.destroy
      redirect_to root_path, notice: 'Your account successfully deleted.'
    else
      render root_path
    end
  end

  private

  def teams
    @teams ||= Team.all
  end

  def games
    @games ||= Game.includes(%i[home_team away_team]).coming.order(date: :asc)
  end

  def account
    @account ||= Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:bookmaker_id)
  end
end
