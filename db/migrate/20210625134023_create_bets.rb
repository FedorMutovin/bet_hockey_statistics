class CreateBets < ActiveRecord::Migration[6.1]
  def change
    create_table :bets do |t|
      t.references :event, foreign_key: true, index: true, null: false
      t.string :result, null: false, default: 'pending'
      t.float :amount, null: false
      t.float :winning_amount, null: false, default: 0.0

      t.timestamps
    end
  end
end
