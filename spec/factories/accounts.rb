FactoryBot.define do
  factory :account do
    user_id { create(:user).id }
    number { '111' }
  end
end
