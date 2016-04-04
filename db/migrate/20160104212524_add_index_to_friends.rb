class AddIndexToFriends < ActiveRecord::Migration
  def change
    add_index :friends, :username
    add_index :friends, :uid
  end
end
