FactoryBot.define do
  factory :bet do
    event { create(:event) }
    result { 'pending' }
    amount { 100 }
  end
end
