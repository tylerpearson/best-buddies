class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :count, :default => 0
      t.decimal :percentage, :precision => 6, :scale => 5

      t.timestamps null: false
    end
  end
end
