class NHL::API::Client
  ROOT_ENDPOINT = 'https://statsapi.web.nhl.com/api/v1/'.freeze

  def initialize
    @client = setup_client
  end

  def games(params = nil)
    @client.get('schedule', params) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body.to_json
    end
  end

  def teams(params = nil)
    @client.get('teams', params) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body.to_json
    end
  end

  private

  def setup_client
    Faraday.new(url: ROOT_ENDPOINT)
  end
end
