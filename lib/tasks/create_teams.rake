namespace :teams do
  namespace :all do
    desc 'create teams'
    task create:
      %i[
        teams:nhl:create
      ]
  end

  namespace :nhl do
    desc 'create NHL team from API/v1/team'
    task create: :environment do
      Team::NHL::CreateService.new.call
    end
  end
end
