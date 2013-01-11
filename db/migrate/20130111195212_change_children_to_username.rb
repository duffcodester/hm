class ChangeChildrenToUsername < ActiveRecord::Migration
  def up
    remove_column :children, :name
    remove_column :children, :email
    add_column :children, :username, :string
    add_index :children, :username, unique: true
  end

  def down
    add_column :children, :name, :string
    add_column :children, :email, :string
    remove_column :children, :username
    remove_index :children, :username
  end
end
