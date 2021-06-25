class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true, index: true
      t.string :balance, default: '0'
      t.string :number, null: false
      t.index ["number"], name: "index_accounts_on_number", unique: true
      t.timestamps
    end
  end
end
