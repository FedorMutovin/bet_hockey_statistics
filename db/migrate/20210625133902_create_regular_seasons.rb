class CreateRegularSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :regular_seasons do |t|
      t.references :season, foreign_key: true, index: true, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
