module HasLeague
  extend ActiveSupport::Concern

  included do
    belongs_to :league
  end
end
