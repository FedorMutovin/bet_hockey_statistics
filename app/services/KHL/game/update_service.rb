class KHL::Game::UpdateService
  KHL_URL = 'https://www.khl.ru/'.freeze
  TEAMS_TYPES = %w[home_team away_team].freeze

  def initialize
    @games = Game.past
  end

  def self.call
    new.call
  end

  def call
    update_service!
  end

  private

  def update_service!
    @games.each do |game|
      response = ::WebScraper.new(KHL_URL + game.link).call
      score_response = response.css('.b-total_score').text
      game.score = score_response.scan(/\d/).join(':')
      game.extra_time = true if score_response.include?('OT') || score_response.include?('Б')
      create_statistics(game, response)
      game.save
    end
  end

  def create_statistics(game, response)
    KHL::Statistic::CreateService.new(game, response).call
  end
end
