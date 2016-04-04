class AddUidToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :uid, :string
  end
end
