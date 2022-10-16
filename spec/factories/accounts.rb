FactoryBot.define do
  sequence :number do |n|
    "70#{n}"
  end
  factory :account do
    user_id { create(:user).id }
    bookmaker_id { create(:bookmaker).id }
    balance { 1000 }
  end
end
