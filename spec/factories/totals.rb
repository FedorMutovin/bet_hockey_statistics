FactoryBot.define do
  factory :total do
    value { 5.0 }
    condition { '<' }
  end
end
