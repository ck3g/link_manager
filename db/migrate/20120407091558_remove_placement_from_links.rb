class RemovePlacementFromLinks < ActiveRecord::Migration
  def up
    remove_column :links, :placement
    add_column :links, :placement_id, :integer
  end

  def down
    add_column :links, :placement, :string
    remove_column :links, :placement_id
  end
end
