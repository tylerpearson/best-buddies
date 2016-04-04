class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :bio, :text
    add_column :users, :website, :string
    add_column :users, :auth_token, :string
  end
end
