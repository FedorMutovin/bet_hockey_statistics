class NHL::CreateService
  attr_reader :method, :league_id, :response, :model_keys, :model

  def initialize(method, params = nil)
    @method = method
    @league_id = League.find_by(name: 'NHL')&.id
    @response = NHL::API::Client.new.send(method, params)
    @model = method.singularize.capitalize.constantize
    @model_keys = model.attribute_names
  end

  def call
    send("create_#{method}!")
    self
  end

  def filtered_params
    params&.map do |hash|
      hash.select { |k, _v| model_keys.include?(k.underscore) }
          .merge(league_id: league_id)
    end
  end

  def params
    JSON.parse(response.body)[method]
  end
end
