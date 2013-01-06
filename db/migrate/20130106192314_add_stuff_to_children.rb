class AddStuffToChildren < ActiveRecord::Migration
  def change
    add_index  :children, :email, unique: true

    add_column :children, :password_digest, :string 

    add_column :children, :remember_token, :string
    add_index  :children, :remember_token
  end
end
