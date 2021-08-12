class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :game, foreign_key: true, index: true, null: false
      t.references :bookmaker, foreign_key: true, index: true, null: false
      t.references :team, foreign_key: true, index: true
      t.float :odds, null: false
      t.belongs_to :eventable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
