class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :aid
      t.string :title
      t.integer :runtime

      t.timestamps null: false
    end
  end
end
