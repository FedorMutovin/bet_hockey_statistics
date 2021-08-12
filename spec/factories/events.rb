FactoryBot.define do
  factory :event do
    game { create(:game, :khl) }
    bookmaker_id { create(:bookmaker).id }
    team_id { create(:team, :khl).id }
    odds { '2' }
    eventable { create(:total) }
  end
end
