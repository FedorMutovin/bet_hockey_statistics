namespace :games do
  namespace :all do
    desc 'create games'
    task create:
           %i[
             games:nhl:create
             games:khl:create
           ]
  end

  namespace :nhl do
    desc 'create NHL team from API/v1/teams'
    task create: :environment do
      game_gap = { startDate: Date.current.to_s, endDate: (Date.current + 2.days).to_s }
      NHL::Game::CreateService.new('games', game_gap).call
    end
  end

  namespace :khl do
    desc 'create KHL games by web_scrapper from /calendar'
    task create: :environment do
      KHL::Game::CreateService.new('games').call
    end
  end
end
