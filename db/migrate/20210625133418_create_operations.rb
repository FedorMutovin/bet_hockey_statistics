class CreateOperations < ActiveRecord::Migration[6.1]
  def change
    create_table :operations do |t|
      t.references :account, foreign_key: true, index: true
      t.belongs_to :operational, polymorphic: true
      t.timestamps
    end
  end
end
