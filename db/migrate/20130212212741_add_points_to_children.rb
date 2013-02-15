class AddPointsToChildren < ActiveRecord::Migration
  def change
    add_column :children, :points, :integer, default: '0'
  end
end
