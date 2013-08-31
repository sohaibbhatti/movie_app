class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :movie_id, null: false

      t.timestamps
    end

    add_index :likes, [:user_id, :movie_id]
    add_index :likes, [:movie_id]
  end
end
