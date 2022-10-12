class DeleteBookmakerIdFromEvents < ActiveRecord::Migration[6.1]
  def up
    remove_reference :events, :bookmaker, index: true, foreign_key: true
  end

  def down
    add_reference :events, :bookmaker, index: true, foreign_key: true
  end
end
