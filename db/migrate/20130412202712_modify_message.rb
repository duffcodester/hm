class ModifyMessage < ActiveRecord::Migration
  def up
    remove_column :messages, :name
    remove_column :messages, :subject
    add_column :messages, :first_name, :string
    add_column :messages, :last_name, :string
  end

  def down
    add_column :messages, :name, :string
    add_column :messages, :subject, :text
  end
end
