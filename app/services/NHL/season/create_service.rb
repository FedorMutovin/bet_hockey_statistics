class NHL::Season::CreateService < NHL::CreateService
  SEASON_PARAMS = %w[seasonId regularSeasonStartDate regularSeasonEndDate].freeze
  CURRENT_YEAR = Date.current.year.to_s

  private

  def create_seasons!
    filtered_params.each do |params|
      next unless params['seasonId'][0..3].eql?(CURRENT_YEAR)

      Season.find_or_create_by!(year: params['seasonId'], league_id: league_id).with_regular_season(
        params['regularSeasonStartDate'],
        params['regularSeasonEndDate']
      )
    end
  end

  def filtered_params
    @filtered_params ||= params&.map do |hash|
      hash.select { |k, _v| SEASON_PARAMS.include?(k) }
    end
  end
end
