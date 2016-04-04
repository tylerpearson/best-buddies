class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :name
      t.string :provider
      t.string :instagram_uid

      t.timestamps null: false
    end
  end
end
