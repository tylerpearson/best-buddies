class DropAvatarColumnFromFriends < ActiveRecord::Migration
  def change
    remove_column :friends, :avatar, :string
  end
end
