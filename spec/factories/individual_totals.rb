FactoryBot.define do
  factory :individual_total do
    value { 1.5 }
    condition { '<' }
  end
end
