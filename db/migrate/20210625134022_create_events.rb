class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :game, foreign_key: true, index: true, null: false
      t.references :bookmaker, foreign_key: true, index: true, null: false
      t.float :odds, null: false
      t.string :name, null: false
      t.timestamps
    end
    add_index :events, :name, unique: true
  end
end
