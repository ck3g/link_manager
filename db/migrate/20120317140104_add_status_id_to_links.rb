class AddStatusIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :status_id, :integer
  end
end
