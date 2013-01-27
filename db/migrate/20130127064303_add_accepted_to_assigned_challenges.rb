class AddAcceptedToAssignedChallenges < ActiveRecord::Migration
  def change
    add_column :assigned_challenges, :accepted, :boolean, default: false
  end
end
