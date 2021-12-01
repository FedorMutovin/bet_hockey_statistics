namespace :games do
  namespace :all do
    desc 'update games'
    task update:
           %i[
             games:nhl:update
           ]
  end

  namespace :nhl do
    desc 'update games info from moneypuck'
    task update: :environment do
      NHL::Game::UpdateService.call
    end
  end
end
