FactoryBot.define do
  factory :event do
    game { create(:game) }
    bookmaker_id { create(:bookmaker).id }
    team_id { create(:team).id }
    odds { '2' }
    eventable { create(:total) }
  end
end
