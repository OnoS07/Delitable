class Admins::RecipesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @search = Recipe.ransack(params[:q])
    if params[:customer_id]
      @customer = Customer.with_deleted.find(params[:customer_id])
      @recipes = Recipe.where(customer_id: @customer.id).order(id: 'DESC').page(params[:page]).per(15)
      @recipe_title = 'レシピ一覧/' + @customer.name + ' 様'
    elsif params[:tag_name]
      @recipes = Recipe.tagged_with(params[:tag_name].to_s).page(params[:page]).per(15)
      @recipe_title = 'レシピ一覧/' + params[:tag_name]
    elsif params[:q]
      @recipes = @search.result(distinct: true).page(params[:page]).per(15)
      @recipe_title = 'レシピ一覧/検索：' + @search.title_or_introduction_or_ingredients_content_cont
    else
      @recipes = Recipe.all.order(id: 'DESC').page(params[:page]).per(15)
      @recipe_title = 'レシピ一覧'
    end
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
    params.require(:recipe).permit(:title, :introduction, :amount, :recipe_image, :recipe_status)
  end
end
