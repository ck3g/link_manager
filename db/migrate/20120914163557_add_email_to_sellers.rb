class AddEmailToSellers < ActiveRecord::Migration
  def change
    add_column :sellers, :email, :string
    add_index :sellers, :email
  end
end
