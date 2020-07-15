class IngredientsController < ApplicationController
  def new
  	@recipe = Recipe.find(params[:recipe_id])
  	@ingredient = Ingredient.new
  	@ingredients = Ingredient.where(recipe_id: @recipe.id)
  end

  def create
  	@ingredient = Ingredient.new(ingredient_params)
  	@ingredient.save
  	redirect_to new_recipe_ingredient_path
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = Ingredient.where(recipe_id: @recipe.id)
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient.update(ingredient_params)
    redirect_to edit_recipe_ingredient_path(@recipe)
  end

  def destroy
  	@ingredient = Ingredient.find(params[:id])
  	@ingredient.destroy
  	redirect_to new_recipe_ingredient_path
  end

  private
  def ingredient_params
  	params.require(:ingredient).permit(:recipe_id, :content, :amount)
  end
end
