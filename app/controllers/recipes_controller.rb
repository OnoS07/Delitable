class RecipesController < ApplicationController
  def new
  	@recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    @recipe.save
  end


  def ingredient
    @recipe = Recipe.new
    @recipe.title = params[:title]
    @recipe.introduction = params[:introduction]
    @recipe.amount = params[:amount]
    @recipe.recipe_image =params[:recipe_image]
    @ingredient = Ingredient.new
  end

  def step; end


  def index; end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :introduction, :amount, :recipe_image)
  end
end
