class NHL::API::Client
  ROOT_ENDPOINT = 'https://statsapi.web.nhl.com/api/v1/'.freeze
  RESOURCES = %w[seasons teams].freeze

  def initialize
    @client = setup_client
  end

  RESOURCES.each do |resource|
    define_method(resource) do |params = nil|
      get_request(resource, params)
    end
  end

  private

  def get_request(url, params = nil)
    @client.get(url, params) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body.to_json
    end
  end

  def setup_client
    Faraday.new(url: ROOT_ENDPOINT)
  end
end
