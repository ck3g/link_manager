class AddOurSiteIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :our_site_id, :integer
    add_index :links, :our_site_id
  end
end
