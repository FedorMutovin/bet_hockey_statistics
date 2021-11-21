FactoryBot.define do
  factory :regular_season do
    season { create(:season) }
    start_date { Date.current - 2.months }
    end_date { Date.current - 1.month }
  end
end
