class CreateSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :seasons do |t|
      t.references :league, foreign_key: true, index: true, null: false
      t.string :year, null: false

      t.timestamps
    end

    add_index :seasons, :year, unique: true
  end
end
