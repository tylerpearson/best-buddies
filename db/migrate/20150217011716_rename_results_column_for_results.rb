class RenameResultsColumnForResults < ActiveRecord::Migration
  def change
    rename_column :results, :count, :like_count
  end
end
