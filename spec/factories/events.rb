FactoryBot.define do
  factory :event do
    game_id { create(:game).id }
    bookmaker_id { create(:bookmaker).id }
    odds { '2.3' }
    name { 'match_winner' }
  end
end
