class AddPopularToUsers < ActiveRecord::Migration
  def change
    add_column :users, :popular, :boolean, default: :false
  end
end
