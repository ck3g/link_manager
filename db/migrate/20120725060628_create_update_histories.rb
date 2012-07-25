class CreateUpdateHistories < ActiveRecord::Migration
  def change
    create_table :update_histories do |t|
      t.integer :link_id
      t.string :url
      t.string :name
      t.integer :page_rank
      t.string :keyword
      t.integer :status_id
      t.integer :placement_id
      t.integer :our_site_id
      t.boolean :inactive

      t.timestamps
    end
    add_index :update_histories, :link_id
    add_index :update_histories, :status_id
    add_index :update_histories, :placement_id
    add_index :update_histories, :our_site_id
    add_index :update_histories, :inactive
  end
end
