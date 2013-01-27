class AddResourceAndDropOthers < ActiveRecord::Migration
  def up
    create_table :resources do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.integer :parent_id
      t.string :type

      t.timestamps
    end

    drop_table :challenges
    drop_table :rewards
  end

  def down
    drop_table :resources
    
    create_table :rewards do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.integer :parent_id

      t.timestamps
    end

    create_table :rewards do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.integer :parent_id

      t.timestamps
    end
  end
end
