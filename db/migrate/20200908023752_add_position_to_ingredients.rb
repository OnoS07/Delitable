class AddPositionToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :position, :integer
  end
end
