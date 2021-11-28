class ChangeStatisticFields < ActiveRecord::Migration[6.1]
  def up
    change_table(:statistics) do |t|
      t.remove :puck_holding_time, :attack_time, :attack_time_percentage,
               :total_shots, :total_shots_against,:shooting_percentage, :team_save_percentage, :goals, :goals_against
      t.belongs_to :statisticable, polymorphic: true, null: false
      t.float :x_goals, :x_goals_against, :power_play, :penalty_kill, :save_percentage, :goals_saved_about_expected
      t.remove_index :game_id
      t.remove_references :team
    end
    add_index :statistics, [:game_id, :statisticable_id], unique: true
  end

  def down
    change_table(:statistics) do |t|
      t.float :attack_time_percentage,:shooting_percentage, :team_save_percentage
      t.integer :goals, :goals_against, :total_shots, :total_shots_against, :puck_holding_time, :attack_time
      t.remove_belongs_to :statisticable, polymorphic: true, null: false
      t.remove :x_goals, :x_goals_against, :power_play, :penalty_kill, :save_percentage, :goals_saved_about_expected
      t.remove_index :game_id
      t.references :team, foreign_key: true, index: true, null: false
    end
    add_index :statistics, [:game_id, :team_id], unique: true
  end
end
