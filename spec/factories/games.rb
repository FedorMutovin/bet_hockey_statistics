FactoryBot.define do
  sequence(:link, 'a') do |n|
    "link#{n}"
  end

  sequence(:api_id, 'a') do |n|
    "id#{n}"
  end

  factory :game do
    link { generate :link }
    api_id { generate :api_id }
    date { DateTime.current + 2.days }
    league_id { create(:league).id }
    season { create(:season) }
    gameable { create(:regular_season, season: season) }
    home_team_id { create(:team).id }
    away_team_id { create(:team).id }
  end
end
