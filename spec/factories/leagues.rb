FactoryBot.define do
  factory :league do
    trait :khl do
      name { 'KHL' }
    end

    trait :nhl do
      name { 'NHL' }
    end
  end
end
