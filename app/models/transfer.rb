class Transfer < ApplicationRecord
  include Operational

  validates :category, :amount, presence: true
  validates :category, inclusion: %w[deposit withdrawal]

  scope :deposit, -> { where(category: 'deposit') }
  scope :withdrawal, -> { where(category: 'withdrawal') }
end
