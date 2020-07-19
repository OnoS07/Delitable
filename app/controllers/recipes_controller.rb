class RecipesController < ApplicationController
  before_action :authenticate_customer!, only:[:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]
  def ensure_correct_customer
    @recipe = Recipe.find(params[:id])
    if current_customer.id != @recipe.customer_id
      redirect_to root_path
    end
  end
  def new
  	@recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    @recipe.save
    if @recipe.recipe_status == nil
      @recipe.update(recipe_status: "レシピ")
      redirect_to new_recipe_ingredient_path(@recipe)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @recipes = Recipe.where(recipe_status: "完成")
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.where(recipe_id: @recipe.id)
    @cookings = Cooking.where(recipe_id: @recipe.id)
    @comments = Comment.where(recipe_id: @recipe.id)
    @comment = Comment.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if params[:recipe_status]
      @recipe.update(recipe_status: "完成")
      redirect_to recipe_path(@recipe)
    elsif @recipe.recipe_status == "レシピ"
      redirect_to new_recipe_ingredient_path(@recipe)
    else
      @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :introduction, :amount, :recipe_image, :recipe_status)
  end

end
