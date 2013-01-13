class ChangeChallengeName < ActiveRecord::Migration
  def up
    remove_column :challenges, :challenge_name
    add_column :challenges, :name, :string
  end

  def down
    add_column :challenges, :challenge_name, :string
    remove_column :challenges, :name
  end
end
