FactoryBot.define do
  factory :event do
    game { create(:game) }
    team_id { create(:team).id }
    odds { '2' }
    eventable { create(:total) }
  end
end
