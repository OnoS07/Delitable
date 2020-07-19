class IngredientsController < ApplicationController
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
  	@ingredient = Ingredient.new
  	@ingredients = Ingredient.where(recipe_id: @recipe.id)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
  	@ingredient = Ingredient.new(ingredient_params)
  	@ingredient.save
    if @recipe.recipe_status == "レシピ"
      @recipe.update(recipe_status: "材料")
    end
    redirect_back(fallback_location: root_path)
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = Ingredient.where(recipe_id: @recipe.id)
    @ingredient = Ingredient.new
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient.update(ingredient_params)
    redirect_back(fallback_location: root_path)
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
