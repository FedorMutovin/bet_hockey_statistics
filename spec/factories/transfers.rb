FactoryBot.define do
  factory :transfer do
    amount { '100' }
    result { 'deposit' }

    trait :withdrawal do
      result { 'withdrawal' }
    end
  end
end
