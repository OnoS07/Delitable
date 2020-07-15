class RemovePointFromCookings < ActiveRecord::Migration[5.2]
  def change
    remove_column :cookings, :point, :string
  end
end
