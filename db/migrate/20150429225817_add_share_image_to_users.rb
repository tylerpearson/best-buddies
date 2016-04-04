class AddShareImageToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :share_image
  end
end
