FactoryBot.define do
  factory :bet do
    event { create(:event) }
    result { 'pending' }
    amount { 100 }
    tax { 0.88 }
  end
end
