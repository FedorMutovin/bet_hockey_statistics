class BetsController < ApplicationController
  before_action :bet, only: :show

  def show; end

  private

  def bet
    @bet ||= Bet.find(params[:id])
  end
end
