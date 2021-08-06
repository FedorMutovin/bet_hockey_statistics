namespace :seasons do
  namespace :all do
    desc 'create seasons'
    task create:
           %i[
             seasons:nhl:create
             seasons:khl:create
           ]
  end

  namespace :nhl do
    desc 'create NHL season from API/v1/seasons'
    task create: :environment do
      NHL::Season::CreateService.new('seasons').call
    end
  end

  namespace :khl do
    desc 'create KHL season by web_scrapper from /calendar'
    task create: :environment do
      KHL::Season::CreateService.new('seasons').call
    end
  end
end
