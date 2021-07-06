FactoryBot.define do
  factory :game do
    league_id { create(:league).id }
    season_id { create(:season).id }
    home_team_id { create(:team).id }
    away_team_id { create(:team).id }
    gameable { create(:regular_season) }
    date { DateTime.current }
    score { '3:2' }
    link { 'lonk' }
    api_id { 'asd' }
  end
end
