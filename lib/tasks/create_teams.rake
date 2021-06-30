namespace :teams do
  namespace :all do
    desc 'create teams'
    task create:
      %i[
        teams:nhl:create
      ]
  end

  namespace :nhl do
    desc 'create NHL team from API/v1/teams'
    task create: :environment do
      NHL::Team::CreateService.new('teams').call
    end
  end
end
