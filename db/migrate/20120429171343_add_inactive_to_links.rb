class AddInactiveToLinks < ActiveRecord::Migration
  def change
    add_column :links, :inactive, :boolean, :default => false
  end
end
