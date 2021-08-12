FactoryBot.define do
  factory :event do
    game_id { create(:game, :khl).id }
    bookmaker_id { create(:bookmaker).id }
    team_id { create(:team, :khl).id }
    odds { '2' }
    name { 'match_winner' }
  end
end
