FactoryBot.define do
  sequence(:bookmaker_name, 'a') do |n|
    "1x#{n}"
  end
  factory :bookmaker do
    name { generate :bookmaker_name }
    country { 'Russia' }
  end
end
