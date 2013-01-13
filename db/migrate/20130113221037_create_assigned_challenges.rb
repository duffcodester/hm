class CreateAssignedChallenges < ActiveRecord::Migration
  def change
    create_table :assigned_challenges do |t|
      t.integer :parent_id
      t.integer :challenge_id
      t.integer :points
      t.boolean :accepted

      t.timestamps
    end
  end
end
