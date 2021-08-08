class KHL::Team::CreateService < KHL::CreateService
  private

  def create_teams!
    ActiveRecord::Base.connection.reset_pk_sequence!('teams')

    names.each_with_index do |name, index|
      Team.find_or_create_by!(
        league_id: league_id,
        name: "#{name} #{cities[index]}"
      )
    end
  end

  %w[cities names].each do |method_name|
    define_method(method_name.to_sym) do
      response.css("#{self.class.name}::TEAM_#{method_name.upcase}_CSS".constantize)&.map { |team| team.text.rstrip }
    end
  end
end
