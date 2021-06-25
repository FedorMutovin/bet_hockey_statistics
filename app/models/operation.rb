class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :operational, polymorphic: true, touch: true
end
