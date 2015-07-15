# Create user entity
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string 'email', unique: true

      t.timestamps null: false
    end
  end
end
