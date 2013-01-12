class AddPublicToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :public, :boolean
  end
end
