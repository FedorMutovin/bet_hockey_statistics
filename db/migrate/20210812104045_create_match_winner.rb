class CreateMatchWinner < ActiveRecord::Migration[6.1]
  def change
    create_table :match_winners do |t|
      t.boolean :with_extra_time, null: false, default: false
      t.timestamps
    end
  end
end
