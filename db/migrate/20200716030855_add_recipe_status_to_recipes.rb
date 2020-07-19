class AddRecipeStatusToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :recipe_status, :integer
  end
end
