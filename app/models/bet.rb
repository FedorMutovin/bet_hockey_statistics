class Bet < ApplicationRecord
  include Operational
  belongs_to :event

  before_update :change_winning_amount_value!, if: :result_changed?

  DEFAULT_BET_RESULTS = %w[win lose return pending].freeze

  accepts_nested_attributes_for :operation, reject_if: :all_blank
  accepts_nested_attributes_for :event, reject_if: :all_blank

  validates :result, :amount, :winning_amount, presence: true
  validates :result, inclusion: DEFAULT_BET_RESULTS
  validates :amount, format: { with: /\A\d+/, message: 'only digits' }

  DEFAULT_BET_RESULTS.each do |result|
    scope result.to_sym, -> { where(result: result) }
    define_method("#{result}?".to_sym) do
      self.result.eql?(result)
    end
  end

  def withdrawal?
    lose? || pending?
  end

  def deposit?
    win? || return?
  end

  def final_amount
    winning_amount
  end

  private

  def change_winning_amount_value!
    Bet::ChangeWinningAmountService.new(self).call
  end
end
