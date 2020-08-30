class RecipesController < ApplicationController
  before_action :authenticate_customer!, only: %i[new create edit update destroy]
  before_action :ensure_correct_customer, only: %i[edit update destroy]
  before_action :close_recipe_show, only: [:show]
  impressionist actions: [:show], unique: %i[impressionable_id ip_address]

  def ensure_correct_customer
    @recipe = Recipe.find(params[:id])
    redirect_to root_path if current_customer.id != @recipe.customer_id
  end

  def close_recipe_show
    @recipe = Recipe.find(params[:id])
    if @recipe.recipe_status != '完成'
      if customer_signed_in?
        redirect_to recipes_path if current_customer.id != @recipe.customer_id
      else
        redirect_to recipes_path
      end
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if @recipe.save
      @recipe.update(recipe_status: 'レシピ')
      flash[:create] = 'NEW RECIPE CREATE !'
      redirect_to edit_recipe_ingredients_path(@recipe)
    else
      flash.now[:notice] = '正しく入力ができていません。もう一度入力して下さい'
      render 'recipes/new'
    end
  end

  def index
    @search = Recipe.ransack(params[:q])
    if params[:tag_name]
      all_recipe = Recipe.where(recipe_status: '完成')
      @recipes = all_recipe.tagged_with(params[:tag_name].to_s).page(params[:page]).per(9)
      @recipe_title = params[:tag_name]
    elsif params[:q]
      @recipes = @search.result(distinct: true).where(recipe_status: '完成').page(params[:page]).per(9)
    elsif params[:favorite]
      all_recipe = Recipe.where(recipe_status: '完成')
      recipe_ids = all_recipe.pluck(:id)
      favorites = Favorite.where(recipe_id: recipe_ids)
      recipe_array = Recipe.find(favorites.group(:recipe_id).order('count(recipe_id) desc').pluck(:recipe_id))
      @recipes = Kaminari.paginate_array(recipe_array).page(params[:page]).per(9)
    else
      @recipes = Recipe.where(recipe_status: '完成').page(params[:page]).per(9)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    impressionist(@recipe, nil, unique: [:ip_address])
    @ingredients = Ingredient.where(recipe_id: @recipe.id)
    @cookings = Cooking.where(recipe_id: @recipe.id)
    @comments = Comment.where(recipe_id: @recipe.id)
    @comment = Comment.new
    flash.now[:ingredient] = '材料がまだ入力されていません。確認して下さい' if @recipe.ingredients.empty?
    flash.now[:cooking] = '作り方がまだ入力されていません。確認して下さい' if @recipe.cookings.empty?

    vegetables = @ingredients.pluck(:content)
    @products = Product.where(name: vegetables)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if params[:recipe_status]
      if @recipe.ingredients.empty?
        redirect_to recipe_path(@recipe)
        flash[:ingredient] = '材料が入力されていないため投稿できません。確認して下さい'
      elsif @recipe.cookings.empty?
        redirect_to recipe_path(@recipe)
        flash[:cooking] = '作り方が入力されていないため投稿できません。確認して下さい'
      else
        @recipe.update(recipe_status: '完成')
        redirect_to recipe_path(@recipe)
        flash[:create] = 'YOUR RECIPE RELEASE !'
      end
    else
      if @recipe.update(recipe_params)
        flash[:create] = 'UPDATE !'
        redirect_to recipe_path(@recipe)
      else
        @recipe = Recipe.find(params[:id])
        flash.now[:notice] = '正しく入力ができていません。もう一度入力して下さい'
        render 'recipes/edit'
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :introduction, :amount, :recipe_image, :recipe_status, :tag_list)
  end
end
