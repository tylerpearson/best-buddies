class AddAvatarToFriendsAgainAgain < ActiveRecord::Migration
  def change
    add_attachment :friends, :avatar
  end
end
