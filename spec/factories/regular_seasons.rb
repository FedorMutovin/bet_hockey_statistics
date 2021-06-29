FactoryBot.define do
  factory :regular_season do
    season_id { create(:season).id }
  end
end
