FactoryBot.define do
  factory :transfer do
    amount { '100' }

    trait :deposit do
      category { 'deposit' }
    end
    trait :withdrawal do
      category { 'withdrawal' }
    end
  end
end
