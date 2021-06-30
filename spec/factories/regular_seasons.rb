FactoryBot.define do
  factory :regular_season do
    season_id { create(:season).id }
    start_date { Date.current - 2.months }
    end_date { Date.current - 1.month }
  end
end
