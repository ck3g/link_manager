class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, :default => 0
    add_index :users, :role
    remove_column :users, :admin
  end
end
