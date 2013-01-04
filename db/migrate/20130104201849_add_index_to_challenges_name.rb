class AddIndexToChallengesName < ActiveRecord::Migration
  def change
    add_index :challenges, :challenge_name
  end
end
