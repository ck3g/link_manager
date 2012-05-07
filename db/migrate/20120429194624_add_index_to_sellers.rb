class AddIndexToSellers < ActiveRecord::Migration
  def change
    add_index :sellers, :seller_origin_id
  end
end
