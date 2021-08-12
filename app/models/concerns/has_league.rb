module HasLeague
  extend ActiveSupport::Concern

  included do
    belongs_to :league

    League::AVAILABLE_LEAGUES_NAMES.each do |name|
      scope name.downcase.to_sym, -> { includes(:league).where(leagues: { name: name }) }
    end
  end
end
