class RemovePointValueFromChallenges < ActiveRecord::Migration
  def up
    remove_column :challenges, :point_value
  end

  def down
    add_column :challenges, :point_value, :integer
  end
end
