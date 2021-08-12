class KHL::CreateService
  attr_reader :method, :league_id, :response, :model_keys, :model

  def initialize(method)
    @method = method
    @league_id = League.find_by(name: 'KHL')&.id
    @response = ::WebScraper.new(PATHS[method]).call
    @model = method.singularize.capitalize.constantize
    @model_keys = model.attribute_names
  end

  def call
    send("create_#{method}!")
    self
  end

  RUS_MONTHS = {
    'сентября' => 9,
    'октября' => 10,
    'ноября' => 11,
    'декабря' => 12,
    'января' => 1,
    'февраля' => 2,
    'марта' => 3,
    'апреля' => 4,
    'мая' => 5,
    'июня' => 6,
    'июля' => 7,
    'августа' => 8
  }.freeze

  PATHS = {
    'seasons' => 'https://www.khl.ru/calendar/',
    'games' => 'https://www.khl.ru/calendar/',
    'teams' => 'https://www.khl.ru/clubs/'
  }.freeze

  DATES_CSS = '.b-final_cup_date b'.freeze

  def filtered_games_dates
    games_dates.select { |element| element.scan(/\d/).present? }&.reject(&:blank?)
  end

  def games_dates
    response.css(DATES_CSS)&.text&.split(', ')&.map do |element|
      element.split('|').last
    end
  end

  def build_date(date)
    date[1] = RUS_MONTHS[date[1]]
    date
  end

  def filter_date(date)
    date.join('-').to_date
  end
end
