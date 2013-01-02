class ChangeDataTypeForChallengePointValue < ActiveRecord::Migration
  def self.up
    change_table :challenges do |t|
      t.change :point_value, :integer
    end
  end

  def self.down
    change_table :challenges do |t|
      t.change :point_value, :string
    end
  end
end
