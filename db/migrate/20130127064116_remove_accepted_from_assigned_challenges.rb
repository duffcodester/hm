class RemoveAcceptedFromAssignedChallenges < ActiveRecord::Migration
  def up
    remove_column :assigned_challenges, :accepted
  end

  def down
    add_column :assigned_challenges, :accepted, :boolean
  end
end
