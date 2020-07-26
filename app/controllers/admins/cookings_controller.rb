class Admins::CookingsController < ApplicationController
  before_action :authenticate_admin!
  def edit
    @recipe = Recipe.find(params[:recipe_id])
  end

  def update
    @cooking = Cooking.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @cooking.update(cooking_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @cooking = Cooking.find(params[:recipe_id])
    @cooking.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def cooking_params
    params.require(:cooking).permit(:recipe_id, :cooking_image, :content)
  end
end
