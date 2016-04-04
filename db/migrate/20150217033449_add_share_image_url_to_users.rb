class AddShareImageUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :share_image_url, :string
  end
end
