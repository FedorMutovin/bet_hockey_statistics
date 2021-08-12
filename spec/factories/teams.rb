FactoryBot.define do
  sequence(:nhl_team_name, 'a') do |n|
    "Florida Panther#{n}"
  end

  sequence(:khl_team_name, 'a') do |n|
    "Сибирь Новосибирск#{n}"
  end

  sequence(:abbreviation, 'A') do |n|
    "FL#{n}"
  end

  factory :team do
    trait :khl do
      name { generate :khl_team_name }
      league_id { create(:league, :khl).id }
    end

    trait :nhl do
      name { generate :nhl_team_name }
      abbreviation
      league_id { create(:league, :nhl).id }
    end
  end
end
