class Transfer < ApplicationRecord
  include Operational

  DEFAULT_TRANSFER_RESULTS = %w[deposit withdrawal].freeze

  validates :result, :amount, presence: true
  validates :result, inclusion: DEFAULT_TRANSFER_RESULTS
  validates :amount, format: { with: /\A\d+/, message: 'only digits' }

  accepts_nested_attributes_for :operation, reject_if: :all_blank

  DEFAULT_BET_RESULTS.each do |result|
    scope result.to_sym, -> { where(result: result) }
    define_method("#{result}?".to_sym) do
      self.result.eql?(result)
    end
  end

  def final_amount
    amount
  end
end
