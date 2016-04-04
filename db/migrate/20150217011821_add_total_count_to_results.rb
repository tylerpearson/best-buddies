class AddTotalCountToResults < ActiveRecord::Migration
  def change
    add_column :results, :total_count, :integer, :default => 0
  end
end
