class AddValidatedToAssignedChallenges < ActiveRecord::Migration
  def change
    add_column :assigned_challenges, :validated, :boolean, default: false
  end
end
