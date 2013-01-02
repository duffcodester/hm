class AddParentToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :parent, :integer
  end
end
