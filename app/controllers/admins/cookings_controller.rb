class Admins::CookingsController < ApplicationController
  def edit
  	@recipe = Recipe.find(params[:recipe_id])
  	@cookings = Cooking.where(recipe_id: @recipe.id)
  	@cooking = Cooking.find(params[:id])
  end

  def update
  end
end
