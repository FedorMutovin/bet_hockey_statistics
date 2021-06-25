class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :mobile_phone, null: false
      t.index ["mobile_phone"], name: "index_users_on_mobile_phone", unique: true

      t.timestamps
    end
  end
end
