class AddChildIdToAssignedChallenges < ActiveRecord::Migration
  def up
    add_column :assigned_challenges, :child_id, :integer
  end

  def down
    remove_column :assigned_challenges, :child_id
  end
end
