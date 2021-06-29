module HasBookmaker
  extend ActiveSupport::Concern

  included do
    belongs_to :bookmaker
  end
end
