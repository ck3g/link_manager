class CreateOurSites < ActiveRecord::Migration
  def change
    create_table :our_sites do |t|
      t.string :name
      t.integer :category_id

      t.timestamps
    end
    add_index :our_sites, :name, :unique => true
    add_index :our_sites, :category_id
  end
end
