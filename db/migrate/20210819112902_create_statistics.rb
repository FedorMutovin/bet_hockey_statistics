class CreateStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :statistics do |t|
      t.references :team, foreign_key: true, index: true, null: false
      t.references :game, foreign_key: true, index: true, null: false
      t.integer :puck_holding_time, null: false, default: 0
      t.integer :attack_time, null: false, default: 0
      t.float :attack_time_percentage, null: false, default: 0.0
      t.integer :total_shots, null: false, default: 0
      t.integer :total_shots_against, null: false, default: 0
      t.float :shooting_percentage, null: false, default: 0.0
      t.float :team_save_percentage, null: false, default: 0.0
      t.integer :goals, null: false, default: 0
      t.integer :goals_against, null: false, default: 0
      t.timestamps
    end
    add_index :statistics, [:game_id, :team_id], unique: true
  end
end
