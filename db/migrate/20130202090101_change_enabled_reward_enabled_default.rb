class ChangeEnabledRewardEnabledDefault < ActiveRecord::Migration
  def self.up
    change_table :enabled_rewards do |t|
      t.change :redeemed, :boolean, default: false
    end
  end

  def self.down
    change_table :enabled_rewards do |t|
      t.change :redeemed, :boolean
    end
  end
end
