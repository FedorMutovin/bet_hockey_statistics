class NHL::Game::UpdateService
  MONEY_PUCK_URL = 'https://moneypuck.com/g.htm?id='.freeze

  def self.call
    new.call
  end

  def call
    update_games!
    self
  end

  private

  def update_games!
    Game.past.each do |game|
      money_puck_html = WebScraper.new(MONEY_PUCK_URL + game.api_id).call
      home_team_score = money_puck_html.css('#homeScoreValue').text
      away_team_score = money_puck_html.css('#awayScoreValue').text
      update_game_attributes(game, home_team_score, away_team_score, money_puck_html)
      update_statistics(game, money_puck_html)
      update_bets_results(game) if game.events.present?
    end
  end

  def update_game_attributes(game, home_team_score, away_team_score, html)
    game.score = "#{home_team_score}:#{away_team_score}"
    game.winner_id = if home_team_score > away_team_score
                       game.home_team_id
                     else
                       game.away_team_id
                     end
    game.extra_time = true if %w[Shootout Overtime].include?(html.css('#period').text)
    game.save
  end

  def update_statistics(game, html)
    NHL::Statistic::CreateService.new(game, html).call
  end

  def update_bets_results(game)
    NHL::Bet::UpdateService.new(game).call
  end
end
