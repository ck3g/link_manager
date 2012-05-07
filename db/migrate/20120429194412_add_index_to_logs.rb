class AddIndexToLogs < ActiveRecord::Migration
  def change
    add_index :logs, :user_id
    add_index :logs, :link_id
  end
end
