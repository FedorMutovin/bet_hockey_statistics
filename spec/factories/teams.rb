FactoryBot.define do
  sequence(:team_name, 'a') do |n|
    "Florida Panther#{n}"
  end

  sequence(:abbreviation, 'A') do |n|
    "FL#{n}"
  end


  factory :team do
    name { generate :team_name }
    abbreviation
    league_id { create(:league).id }
  end
end
