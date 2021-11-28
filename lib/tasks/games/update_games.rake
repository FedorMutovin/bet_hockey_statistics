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
    task update: :environment do
      NHL::Game::CreateService.new('games').call
    end
  end
end
