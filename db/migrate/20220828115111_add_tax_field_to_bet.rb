class AddTaxFieldToBet < ActiveRecord::Migration[6.1]
  def change
    add_column :bets, :tax, :float
  end
end
