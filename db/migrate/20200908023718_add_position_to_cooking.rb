class AddPositionToCooking < ActiveRecord::Migration[5.2]
  def change
    add_column :cookings, :position, :integer
  end
end
