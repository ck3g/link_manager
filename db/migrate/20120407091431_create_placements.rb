class CreatePlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.string :name

      t.timestamps
    end
  end
end
