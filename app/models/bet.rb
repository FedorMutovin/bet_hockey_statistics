class Bet < ApplicationRecord
  include Operational
  belongs_to :event

  before_update :change_final_amount_value!, if: :result_changed?

  DEFAULT_RESULTS = %w[win lose return pending].freeze

  accepts_nested_attributes_for :operation, reject_if: :all_blank
  accepts_nested_attributes_for :event, reject_if: :all_blank

  validates :result, :amount, :final_amount, presence: true
  validates :result, inclusion: DEFAULT_RESULTS
  validates :amount, format: { with: /\A\d+/, message: 'only digits' }

  DEFAULT_RESULTS.each do |result|
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

  private

  def change_final_amount_value!
    return unless win? && final_amount <= 0

    self.final_amount = final_amount + (amount * event.odds) if win?
    operation.send(:change_account_balance!)
  end
end
