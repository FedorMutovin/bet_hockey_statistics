FactoryBot.define do
  sequence :year do |n|
    "2020200#{n}"
  end

  factory :season do
    year
    league { create(:league) }
  end
end
