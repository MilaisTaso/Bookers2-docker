class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :user_id
      t.integer :ohter_user_id
      t.timestamps
    end
    add_index :rooms, [:user_id, :ohter_user_id], unique: true
  end
end
