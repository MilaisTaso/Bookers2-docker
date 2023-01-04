class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :room_id
      t.text :chat
      t.timestamps
    end
  end
end
