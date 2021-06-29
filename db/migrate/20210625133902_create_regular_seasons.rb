class CreateRegularSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :regular_seasons do |t|
      t.references :season, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
