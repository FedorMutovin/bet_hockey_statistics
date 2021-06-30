Dir[Rails.root.join('db/seeds/*.rb')].sort.each do |file|
  puts "Processing #{file.split('/').last}"
  require file
end

user = User.create!(mobile_phone: '79823205166')
bookmaker = Bookmaker.create!(name: '1xСтавка', country: 'Russia')
account = Account.create!(user: user, number: '1', bookmaker: bookmaker)
transfer = Transfer.create!(category: "deposit", amount: '100')
league = League.create!(name: 'NHL')
season = Season.create!(league: league, year: '2020-21')
home_team = Team.create!(name: 'Florida Panthers', abbreviation: 'FLA', league: league)
away_team = Team.create!(name: 'San Jose Sharks', abbreviation: 'SJS', league: league)
regular_season = RegularSeason.create!(season: season)
game = Game.create!(
  league: league,
  season: season,
  home_team: home_team,
  away_team: away_team,
  gameable: regular_season,
  date: DateTime.current,
  score: '3:2')
event = Event.create!(game: game, bookmaker: bookmaker, odds: '2.2', name: 'match_winner')
bet = Bet.create!(event: event, result: 'win', amount: '100')
operations = [{ account: account, operational: transfer },
              { account: account, operational: bet }]
operations.each {|operation| Operation.create!(operation)}
