class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.integer :parent_id

      t.timestamps
    end
  end
end
