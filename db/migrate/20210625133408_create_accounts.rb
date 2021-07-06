class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.references :bookmaker, foreign_key: true, index: true, null: false
      t.float :balance, null: false, default: '0'
      t.string :number, null: false
      t.timestamps
    end
    add_index :accounts, :number, unique: true
  end
end
