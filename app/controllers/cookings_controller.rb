class CookingsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]
  def ensure_correct_customer
    @recipe = Recipe.find(params[:recipe_id])
    if current_customer.id != @recipe.customer_id
      redirect_to root_path
    end
  end
  def new
  	@recipe = Recipe.find(params[:recipe_id])
  	@ingredients = Ingredient.where(recipe_id: @recipe.id)
  	@cooking = Cooking.new
  	@cookings = Cooking.where(recipe_id: @recipe.id)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
  	@cooking = Cooking.new(cooking_params)
    @cookings = @recipe.cookings.all
  	@cooking.save
    if @recipe.recipe_status == "材料"
      @recipe.update(recipe_status: "作り方")
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @cooking = Cooking.new
    @cookings = Cooking.where(recipe_id: @recipe.id)
  end

  def update
    @cooking = Cooking.find(params[:id])
    @cookings = @recipe.cookings.all
    @recipe = Recipe.find(params[:recipe_id])
    @cooking.update(cooking_params)
  end

  def destroy
  	@cooking = Cooking.find(params[:id])
  	@cooking.destroy
    @cookings = @recipe.cookings.all
  end

  private
  def cooking_params
  	params.require(:cooking).permit(:recipe_id, :cooking_image, :content)
  end

end
