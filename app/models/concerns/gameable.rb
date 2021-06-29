module Gameable
  extend ActiveSupport::Concern

  included do
    has_many :games, dependent: :destroy, as: :gameable
  end
end
