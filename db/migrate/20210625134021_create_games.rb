class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.references :league, foreign_key: true, index: true, null: false
      t.references :season, foreign_key: true, index: true, null: false
      t.references :home_team, foreign_key: { to_table: :teams }, index: true, null: false
      t.references :away_team, foreign_key: { to_table: :teams }, index: true, null: false
      t.belongs_to :gameable, polymorphic: true, null: false
      t.datetime :date, null: false
      t.string :link
      t.string :api_id
      t.string :score
      t.timestamps
    end
    add_index :games, [:date, :away_team_id, :home_team_id], unique: true, name: "idx_teams_date_uniq"
  end
end
