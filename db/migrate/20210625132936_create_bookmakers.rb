class CreateBookmakers < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmakers do |t|
      t.string :name, null: false
      t.string :country, null: false
      t.timestamps
    end
    add_index :bookmakers, :name, unique: true
  end
end
