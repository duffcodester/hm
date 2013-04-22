class ChangeChildren < ActiveRecord::Migration
  def up
    remove_column :children, :avatar
    add_column :children, :avatar, :string, default: "hm_hero_home"
  end

  def down
    add_column :children, :avatar, :string
  end
end
