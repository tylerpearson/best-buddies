class AddImageColumnToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :instagram_avatar_url, :string
  end
end
