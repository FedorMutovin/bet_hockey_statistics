module HasLeague
  extend ActiveSupport::Concern

  AVAILABLE_LEAGUES_NAMES = %w[NHL KHL].freeze

  included do
    belongs_to :league

    AVAILABLE_LEAGUES_NAMES.each do |name|
      scope name.downcase.to_sym, -> { includes(:league).where(leagues: { name: name }) }
    end
  end
end
