class CreateSellerOrigins < ActiveRecord::Migration
  def change
    create_table :seller_origins do |t|
      t.string :name

      t.timestamps
    end
  end
end
