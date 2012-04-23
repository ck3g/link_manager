class AddSellerOriginIdToSellers < ActiveRecord::Migration
  def change
    add_column :sellers, :seller_origin_id, :integer
  end
end
