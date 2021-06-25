FactoryBot.define do
  sequence :mobile_phone do |n|
    "7900000000#{n}"
  end

  factory :user do
    mobile_phone
  end
end
