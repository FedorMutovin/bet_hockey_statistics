FactoryBot.define do
  sequence(:name, 'A') do |n|
    "NH#{n}"
  end

  factory :league do
    name
  end
end
