class AddRejectedToAssignedChallenges < ActiveRecord::Migration
  def change
    add_column :assigned_challenges, :rejected, :boolean, default: false
  end
end
