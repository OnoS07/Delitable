class CookingsController < ApplicationController
  def new
  	@recipe = Recipe.find(params[:recipe_id])
  	@ingredients = Ingredient.where(recipe_id: @recipe.id)
  	@cooking = Cooking.new
  	@cookings = Cooking.where(recipe_id: @recipe.id)
  end

  def create
  	@cooking = Cooking.new(cooking_params)
  	@cooking.save
    redirect_to new_recipe_cooking_path
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @cooking = Cooking.new
    @cookings = Cooking.where(recipe_id: @recipe.id)
  end

  def update
    @cooking = Cooking.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @cooking.update(cooking_params)
    redirect_to edit_recipe_cooking_path(@recipe)
  end

  def destroy
  	@cooking = Cooking.find(params[:id])
  	@cooking.destroy
  	redirect_to new_recipe_cooking_path
  end

  private
  def cooking_params
  	params.require(:cooking).permit(:recipe_id, :cooking_image, :content)
  end

end
