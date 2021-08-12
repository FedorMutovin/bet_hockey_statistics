class CreateHandicap < ActiveRecord::Migration[6.1]
  def change
    create_table :handicaps do |t|
      t.float :value, null: false

      t.timestamps
    end
  end
end
