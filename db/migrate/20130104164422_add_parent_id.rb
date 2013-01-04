class AddParentId < ActiveRecord::Migration
  def up
    add_column :challenges, :parent_id, :integer
  end

  def down
    remove_column :challenges, :parent_id
  end
end
