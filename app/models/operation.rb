class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :operational, polymorphic: true, touch: true
  validates :operational_id, :operational_type, presence: true
end
