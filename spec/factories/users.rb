FactoryBot.define do
  sequence :mobile_phone do |n|
    "7900000000#{n}"
  end

  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    mobile_phone
    email
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
