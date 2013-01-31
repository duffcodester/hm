class AddCompletedToAssignedChallenges < ActiveRecord::Migration
  def change
    add_column :assigned_challenges, :completed, :boolean, default: false
  end
end
