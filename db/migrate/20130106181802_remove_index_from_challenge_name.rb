class RemoveIndexFromChallengeName < ActiveRecord::Migration
  def up
    remove_index :challenges, :challenge_name
  end

  def down
    add_index :challenges, :challenge_name
  end
end
