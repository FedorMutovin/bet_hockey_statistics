class Season < ApplicationRecord
  include HasLeague
  has_one :regular_season, dependent: :destroy
  has_one :playoff, dependent: :destroy
  validates :year, presence: true, uniqueness: { case_sensitive: false },
                   format: { with: /\A\d{4}-\d{2}/, message: 'yyyy-yy format' }
end
