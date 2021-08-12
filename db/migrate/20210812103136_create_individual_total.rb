class CreateIndividualTotal < ActiveRecord::Migration[6.1]
  def change
    create_table :individual_totals do |t|
      t.float :value, null: false
      t.string :condition, null: false

      t.timestamps
    end
  end
end
