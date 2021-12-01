require 'rails_helper'

RSpec.describe NHL::Statistic::CreateService do
  subject(:statistic_create_service) { described_class.new(game, html) }

  let!(:game) { create(:game, api_id: '2021020342', date: DateTime.current - 2.days) }
  let!(:html) { WebScraper.new("https://moneypuck.com/g.htm?id=#{game.api_id}").call }

  it 'create game statistic' do
    expect { statistic_create_service.call }.to change(Statistic, :count).by(2)
    home_team_statistic = game.statistics.find_by(statisticable_id: game.home_team_id)
    away_team_statistic = game.statistics.find_by(statisticable_id: game.away_team_id)
    expect(home_team_statistic.x_goals).to eq(4.09)
    expect(home_team_statistic.x_goals_against).to eq(1.63)
    expect(home_team_statistic.save_percentage).to eq(100)
    expect(home_team_statistic.goals_saved_about_expected).to eq(1.63)
    expect(away_team_statistic.x_goals).to eq(1.63)
    expect(away_team_statistic.x_goals_against).to eq(4.09)
    expect(away_team_statistic.save_percentage).to eq(78)
    expect(away_team_statistic.goals_saved_about_expected).to eq(-0.95)
  end
end
