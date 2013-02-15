class RemovePointsFromChildren < ActiveRecord::Migration
  def change
    remove_column :children, :points
  end
end
