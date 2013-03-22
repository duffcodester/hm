class AddCategoryIdToAssignedChallenges < ActiveRecord::Migration
  def change
    add_column :assigned_challenges, :category_id, :integer
  end
end
