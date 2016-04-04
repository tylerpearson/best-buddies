class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :username
      t.string :name
      t.text :bio
      t.string :website
      t.string :avatar

      t.timestamps null: false
    end
  end
end
