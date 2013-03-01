class AddAgeGroupToChildren < ActiveRecord::Migration
  def change
    add_column :children, :age_group, :string
  end
end
