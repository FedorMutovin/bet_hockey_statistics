FactoryBot.define do
  factory :game do
    link { 'lonk' }
    api_id { 'asd' }
    date { DateTime.current }

    trait :khl do
      league_id { create(:league, :khl).id }
      season { create(:season, :khl) }
      gameable { create(:regular_season, season: season) }
      home_team_id { create(:team, :khl).id }
      away_team_id { create(:team, :khl).id }
    end

    trait :nhl do
      league_id { create(:league, :nhl).id }
      season { create(:season, :nhl) }
      gameable { create(:regular_season, season: season) }
      link { 'lonk' }
      api_id { 'asd' }
      home_team_id { create(:team, :nhl).id }
      away_team_id { create(:team, :nhl).id }
    end
  end
end
