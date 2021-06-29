FactoryBot.define do
  sequence :year do |n|
    "2020-2#{n}"
  end

  factory :season do
    league_id { create(:league).id }
    year
  end
end
