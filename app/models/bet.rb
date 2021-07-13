class Bet < ApplicationRecord
  include Operational
  belongs_to :event

  accepts_nested_attributes_for :operation, reject_if: :all_blank
  accepts_nested_attributes_for :event, reject_if: :all_blank

  validates :result, :amount, presence: true
  validates :result, inclusion: %w[win lose return pending]
  validates :amount, format: { with: /\A\d+/, message: 'only digits' }

  scope :win, -> { where(category: 'win') }
  scope :lose, -> { where(category: 'lose') }
  scope :return, -> { where(category: 'return') }
  scope :pending, -> { where(category: 'pending') }
end
