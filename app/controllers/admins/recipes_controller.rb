class Admins::RecipesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @recipes = Recipe.all.order(id: 'DESC')
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to admins_recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to admins_recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :introduction, :amount, :recipe_image)
  end
end
