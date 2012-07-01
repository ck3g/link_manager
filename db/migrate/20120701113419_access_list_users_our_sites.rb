class AccessListUsersOurSites < ActiveRecord::Migration
  def change
    create_table :access_list_users_our_sites, :id => false do |t|
      t.integer :user_id
      t.integer :our_site_id
    end
    add_index :access_list_users_our_sites, :user_id
    add_index :access_list_users_our_sites, :our_site_id
  end
end
