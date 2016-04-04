class AddHasResultsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_results, :boolean, :default => false
  end
end
