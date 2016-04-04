class DropColumnFromResults < ActiveRecord::Migration
  def change
    remove_column :results, :percentage
  end
end
