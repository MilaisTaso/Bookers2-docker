class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body
      t.float :score
      t.integer :category
      t.integer :user_id
      t.timestamps
    end
  end
end
