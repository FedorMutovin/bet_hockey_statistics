FactoryBot.define do
  sequence :year do |n|
    "2020200#{n}"
  end

  factory :season do
    year

    trait :khl do
      league { create(:league, :khl) }
    end

    trait :nhl do
      league { create(:league, :nhl) }
    end
  end
end
