class Admins::IngredientsController < ApplicationController
  before_action :authenticate_admin!
  def edit
    @recipe = Recipe.find(params[:recipe_id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    if @ingredient.update(ingredient_params)
      redirect_back(fallback_location: root_path)
    else
      redirect_to edit_admins_recipe_ingredient_path(@recipe, @ingredient), flash: { error_messages: @ingredient.errors.full_messages }
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:recipe_id, :content, :amount)
  end
end
