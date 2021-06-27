FactoryBot.define do
  factory :transfer do
    amount { '100' }
    category { 'deposit' }

    trait :withdrawal do
      category { 'withdrawal' }
    end
  end
end
