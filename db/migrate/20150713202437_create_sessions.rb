class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.belongs_to :movie, index: true
      t.datetime :date

      t.timestamps null: false
    end

    add_index :sessions, [:movie_id, :date], unique: true
  end
end
