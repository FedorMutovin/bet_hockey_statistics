class ChangeTypeToDecimal < ActiveRecord::Migration[6.1]
  def up
    change_column(:bets, :amount, :decimal)
    change_column(:bets, :winning_amount, :decimal)
    change_column_default :bets, :winning_amount, 0
    change_column(:transfers, :amount, :decimal)
  end

  def down
    change_column(:bets, :amount, :float)
    change_column(:bets, :winning_amount, :float)
    change_column_default :bets, :winning_amount, 0.0
    change_column(:transfers, :amount, :float)
  end
end
