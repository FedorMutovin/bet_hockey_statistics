class Transfer < ApplicationRecord
  include Operational

  validates :category, :amount, presence: true
  validates :category, inclusion: %w[deposit withdrawal]
  validates :amount, format: { with: /\A\d+/, message: 'only digits' }

  accepts_nested_attributes_for :operation, reject_if: :all_blank

  scope :deposit, -> { where(category: 'deposit') }
  scope :withdrawal, -> { where(category: 'withdrawal') }

  def withdrawal?
    category.eql?('withdrawal')
  end

  def deposit?
    category.eql?('deposit')
  end

  def final_amount
    amount
  end
end
