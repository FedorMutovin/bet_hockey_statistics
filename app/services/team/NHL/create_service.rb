class Team::NHL::CreateService
  attr_reader :response, :league_id

  TEAM_KEYS = %w[name abbreviation].freeze

  def initialize
    @league_id = League.find_by(name: 'NHL')&.id
    @response = NHL::API::Client.new.teams
  end

  def call
    create_teams! if response.success?
  end

  def create_teams!
    filtered_params.each { |params| Team.find_or_create_by!(params) }
  rescue ActiveRecord::RecordInvalid => e
    puts e.message
  end

  def filtered_params
    @filtered_params ||= teams_params&.map do |hash|
      hash.select { |k, _v| TEAM_KEYS.include?(k) }
          .merge(league_id: league_id)
    end
  end

  def teams_params
    @teams_params ||= JSON.parse(response.body)['teams']
  end
end
