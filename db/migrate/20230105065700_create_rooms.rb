class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :relationship_id, null: false
      t.integer :other_relationship_id, null: false
      t.timestamps
    end
  end
end
