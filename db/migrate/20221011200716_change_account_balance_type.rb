class ChangeAccountBalanceType < ActiveRecord::Migration[6.1]
  def up
    change_column(:accounts, :balance, :decimal)
    change_column_default :accounts, :balance, 0
  end

  def down
    change_column(:accounts, :balance, :float)
    change_column_default :accounts, :balance, '0'
  end
end
