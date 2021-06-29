FactoryBot.define do
  factory :playoff do
    season_id { create(:season).id }
  end
end
