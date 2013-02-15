class DestroyEnabledRewards < ActiveRecord::Migration
  def change
    drop_table :enabled_rewards
  end
end
