class AddPointsToChildren < ActiveRecord::Migration
  def change
    add_column :children, :points, :integer
  end
end
