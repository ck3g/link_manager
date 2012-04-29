class AddIndexToLinks < ActiveRecord::Migration
  def change
    add_index :links, :user_id
    add_index :links, :status_id
    add_index :links, :placement_id
  end
end
