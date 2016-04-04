class RenameIdOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :instagram_uid, :uid
  end
end
