class CreateTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :transfers do |t|
      t.string :result, null: false
      t.float :amount, null: false

      t.timestamps
    end
  end
end
