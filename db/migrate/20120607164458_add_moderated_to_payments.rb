class AddModeratedToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :moderated, :boolean, :default => false
  end
end
