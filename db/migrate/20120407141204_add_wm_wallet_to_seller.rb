class AddWmWalletToSeller < ActiveRecord::Migration
  def change
    add_column :sellers, :wm_wallet, :string
  end
end
