class NHL::Team::CreateService < NHL::CreateService
  private

  def create_teams!
    filtered_params.each { |params| Team.find_or_create_by!(params) }
  rescue ActiveRecord::RecordInvalid => e
    puts e.message
  end
end
