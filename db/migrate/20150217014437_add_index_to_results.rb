class AddIndexToResults < ActiveRecord::Migration
  def change
    add_index :results, :user_id
    add_index :results, :friend_id
  end
end
