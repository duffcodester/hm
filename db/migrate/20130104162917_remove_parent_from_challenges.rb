class RemoveParentFromChallenges < ActiveRecord::Migration
  def up
    remove_column :challenges, :parent
  end

  def down
    add_column :challenges, :parent, :integer
  end
end
