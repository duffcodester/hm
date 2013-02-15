class CreateEnabledRewards < ActiveRecord::Migration
  def change
    create_table :enabled_rewards do |t|
      t.integer :parent_id
      t.integer :reward_id
      t.integer :points
      t.boolean :redeemed, default: false
      t.integer :child_id

      t.timestamps
    end
  end
end
