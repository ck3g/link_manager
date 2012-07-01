class AccessListUsersPaymentMethods < ActiveRecord::Migration
  def change
    create_table :access_list_users_payment_methods, :id => false do |t|
      t.integer :user_id
      t.integer :payment_method_id
    end
    add_index :access_list_users_payment_methods, :user_id
    add_index :access_list_users_payment_methods, :payment_method_id
  end
end
