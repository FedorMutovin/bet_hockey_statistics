FactoryBot.define do
  factory :bet do
    result { 'win' }
    odds { '2,34' }
    event { 'Match Winner' }
    league { 'NHL' }
    home_team { 'Seattle Kraken' }
    away_team { 'Winnipeg Jets' }
    match_date { DateTime.current }
    amount { 100 }
  end
end
