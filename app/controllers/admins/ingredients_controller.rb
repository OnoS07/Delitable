class Admins::IngredientsController < ApplicationController
  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = Ingredient.where(recipe_id: @recipe.id)
    @ingredient = Ingredient.new
  end
end
