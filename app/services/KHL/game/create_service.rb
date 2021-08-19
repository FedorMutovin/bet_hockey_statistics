class KHL::Game::CreateService < KHL::CreateService
  GAMES_TIMES_CSS = '.b-total_score h3'.freeze
  UTC = 3.hours

  private

  def create_games!
    filtered_games_dates.each_with_index do |date, index|
      Game.find_or_create_by!(
        league_id: league_id,
        home_team_id: team_id(home_teams[index]),
        away_team_id: team_id(away_teams[index]),
        date: filter_date(build_date(date.split(' ')), index),
        season_id: season.id,
        gameable: type(@date),
        link: links[index]
      )
    end
  end

  def home_teams
    @home_teams ||= response.css('.b-details').css('.m-club').css('.b-details_txt').css('.e-club_name').map(&:text)
  end

  def away_teams
    @away_teams ||= response.css('.b-details').css('.m-club').css('.m-rightward').css('.b-details_txt')
                            .css('.e-club_name').map(&:text)
  end

  def links
    @links = response.css('.b-title-option div div ul li a')
                     .select { |link| link.values.first.include?('preview') }
                     .map { |link| link.values.first.gsub('preview', 'protocol') }
  end

  def games_times
    @games_times ||= response.css(GAMES_TIMES_CSS).text.split(' ').map { |time| time.gsub('мск', '') }.reject(&:blank?)
  end

  def team_id(team_name)
    KHL::Team::FindForGameService.new(team_name).call.id
  end

  def filter_date(date, index)
    @date = "#{date.join('-')} #{games_times[index]}".to_datetime - UTC
  end

  def season
    @season ||= Season.khl.last
  end

  def type(game_date)
    game_date <= regular_season_end_date ? @season.regular_season : @season.playoff
  end

  def regular_season_end_date
    @season.regular_season.end_date.to_datetime
  end
end
