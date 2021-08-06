FactoryBot.define do
  factory :bet do
    event_id { create(:event).id }
    result { 'pending' }
    amount { 100 }
  end
end
