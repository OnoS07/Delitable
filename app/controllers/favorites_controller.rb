class FavoritesController < ApplicationController
  def create
  	recipe = Recipe.find(params[:recipe_id])
  	favorite = Favorite.new
  	favorite.customer_id = current_customer.id
  	favorite.recipe_id = recipe.id
  	favorite.save
  	redirect_back(fallback_location: root_path)
  end

  def destroy
  	recipe = Recipe.find(params[:recipe_id])
  	favorite = current_customer.favorites.find_by(recipe_id: recipe.id)
  	favorite.destroy
  	redirect_back(fallback_location: root_path)
  end
end
