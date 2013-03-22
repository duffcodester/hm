class AddCategoryIdToResoureces < ActiveRecord::Migration
  def change
    add_column :resources, :category_id, :integer
  end
end
