namespace :games do
  namespace :all do
    desc 'create games'
    task create:
           %i[
             games:nhl:create
           ]
  end

  namespace :nhl do
    desc 'create NHL team from API/v1/teams'
    task create: :environment do
      game_gap = { startDate: Date.current.to_s, endDate: (Date.current + 1.day).to_s }
      NHL::Game::CreateService.new('games', game_gap).call
    end
  end
end
