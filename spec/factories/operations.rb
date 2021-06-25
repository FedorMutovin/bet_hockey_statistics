FactoryBot.define do
  factory :operation do
    account { create(:account) }
    trait :with_transfer do
      operational { create(:transfer) }
    end

    trait :with_bet do
      operational { create(:bet) }
    end
  end
end
