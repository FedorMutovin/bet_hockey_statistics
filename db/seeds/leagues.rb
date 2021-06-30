LEAGUES = %w[KHL NHL].freeze
LEAGUES.each {|league| League.find_or_create_by(name: league)}