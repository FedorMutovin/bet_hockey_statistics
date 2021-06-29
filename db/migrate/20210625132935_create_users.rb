class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :mobile_phone, null: false

      t.timestamps
    end
    add_index :users, :mobile_phone, unique: true
  end
end
