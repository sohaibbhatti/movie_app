class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.text :genres
      t.integer :year, limit: 2

      t.timestamps
    end
  end
end
