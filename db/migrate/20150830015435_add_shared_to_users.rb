class AddSharedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shared, :boolean
    add_index :users, :shared
  end
end
