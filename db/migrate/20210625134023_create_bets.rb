class CreateBets < ActiveRecord::Migration[6.1]
  def change
    create_table :bets do |t|
      t.string :result, null: false
      t.string :odds, null: false
      t.string :event, null: false
      t.string :league, null: false
      t.string :home_team, null: false
      t.string :away_team, null: false
      t.datetime :match_date, null: false

      t.timestamps
    end
  end
end
