class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.references :league, foreign_key: true, index: true, null: false
      t.string :name, null: false
      t.string :abbreviation, null: false
      t.timestamps
    end
    add_index :teams, [:name, :abbreviation], unique: true
  end
end
