class AddIndexToPayments < ActiveRecord::Migration
  def change
    add_index :payments, :link_id
    add_index :payments, :user_id
    add_index :payments, :seller_id
    add_index :payments, :payment_method_id
  end
end
