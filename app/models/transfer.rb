class Transfer < ApplicationRecord
  include Operational

  validates :result, :amount, presence: true
  validates :result, inclusion: %w[deposit withdrawal]
  validates :amount, format: { with: /\A\d+/, message: 'only digits' }

  accepts_nested_attributes_for :operation, reject_if: :all_blank

  scope :deposit, -> { where(result: 'deposit') }
  scope :withdrawal, -> { where(result: 'withdrawal') }

  def withdrawal?
    result.eql?('withdrawal')
  end

  def deposit?
    result.eql?('deposit')
  end

  def final_amount
    amount
  end
end
