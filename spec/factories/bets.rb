FactoryBot.define do
  factory :bet do
    event_id { create(:event).id }
    result { 'win' }
    amount { 100 }
  end
end
