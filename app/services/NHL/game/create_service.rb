class NHL::Game::CreateService < NHL::CreateService
  GAME_PARAMS = %w[gamePk link season gameDate teams].freeze
  MSK_TIMEZONE = 3.hours

  private

  def create_games!
    filtered_params.each { |params| Game.find_or_create_by!(create_params(params)) }
  rescue ActiveRecord::RecordInvalid => e
    puts e.message
  end

  def filtered_params
    @filtered_params ||= params&.map do |hash|
      hash.select { |k, _v| GAME_PARAMS.include?(k) }
          .merge(league_id: league_id)
    end
  end

  def teams(teams_params)
    NHL::Team::FindForGameService.new(teams_params).call
  end

  def season(season_params)
    @season = NHL::Season::FindForGameService.new(season_params).call.season
  end

  def date(date_params)
    @date = date_params.to_datetime + MSK_TIMEZONE
  end

  def type(game_date)
    game_date <= regular_season_end_date ? @season.regular_season : @season.playoff
  end

  def create_params(params)
    { league_id: params[:league_id],
      season_id: season(params['season']).id,
      api_id: params['gamePk'],
      link: params['link'],
      date: date(params['gameDate']),
      away_team_id: teams(params['teams']).away_id,
      home_team_id: teams(params['teams']).home_id,
      gameable: type(@date) }
  end

  def params
    @params ||= JSON.parse(response.body)['dates'].map { |date| date['games'] }.flatten
  end

  def regular_season_end_date
    @season.regular_season.end_date.to_datetime
  end
end
