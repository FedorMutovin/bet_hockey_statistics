class KHL::Season::CreateService < KHL::CreateService
  private

  def create_seasons!
    Season.find_or_create_by!(year: year, league_id: league_id)
          .with_regular_season(filter_date(start_date), filter_date(end_date))
  end

  def start_date
    @start_date ||= build_date(filtered_games.first.split(' '))
  end

  def end_date
    @end_date = build_date(filtered_games.last.split(' '))
  end

  def year
    @year ||= start_date.last + end_date.last
  end
end
