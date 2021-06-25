class Transfer < ApplicationRecord
  has_one :operation, dependent: :destroy, as: :operational

  validates :category, :amount, presence: true
  validates :category, inclusion: %w[deposit withdrawal]

  scope :deposit, -> { where(category: 'deposit') }
  scope :withdrawal, -> { where(category: 'withdrawal') }
end
