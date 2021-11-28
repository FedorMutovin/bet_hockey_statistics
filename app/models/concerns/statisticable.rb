module Statisticable
  extend ActiveSupport::Concern

  included do
    has_many :statistics, dependent: :destroy, as: :statisticable
  end
end
