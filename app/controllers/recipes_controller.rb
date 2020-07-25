class RecipesController < ApplicationController
  before_action :authenticate_customer!, only:[:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]
  before_action :close_recipe_show, only:[:show]
  impressionist :actions=> [:show], :unique => [:impressionable_id, :ip_address]

  def ensure_correct_customer
    @recipe = Recipe.find(params[:id])
    if current_customer.id != @recipe.customer_id
      redirect_to root_path
    end
  end
  def close_recipe_show
    # 完成以外のレシピ詳細を他のユーザーから見れないようにする
    @recipe = Recipe.find(params[:id])
    if @recipe.recipe_status != "完成"
      if customer_signed_in?
        if current_customer.id != @recipe.customer_id
          redirect_to recipes_path
        end
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
      @recipe.update(recipe_status: "レシピ")
      flash[:create] = "NEW RECIPE CREATE !"
      redirect_to edit_recipe_ingredients_path(@recipe)
    else
      flash.now[:notice] = "正しく入力ができていません。もう一度入力して下さい"
      render ("recipes/new")
    end
  end

  def index

    @search = Recipe.ransack(params[:q])
    if params[:tag_name]
      # タグ検索結果
      all_recipe = Recipe.where(recipe_status: "完成")
      @recipes = all_recipe.tagged_with("#{params[:tag_name]}")
      @recipe_title = params[:tag_name]
    elsif params[:q]
      # キーワード検索結果
      @recipes = @search.result.where(recipe_status: "完成")
    elsif params[:impression]
      # 閲覧数順結果
      all_recipes = Recipe.where(recipe_status: "完成")
      @recipes = all_recipes.order(impressions_count: 'DESC')
    else
      # シンプルに一覧
      @recipes = Recipe.where(recipe_status: "完成")
    end

  end

  def show
    @recipe = Recipe.find(params[:id])
    impressionist(@recipe, nil, unique: [:ip_address])
    @ingredients = Ingredient.where(recipe_id: @recipe.id)
    @cookings = Cooking.where(recipe_id: @recipe.id)
    @comments = Comment.where(recipe_id: @recipe.id)
    @comment = Comment.new
    # どこが未入力がメッセージを表示
    if @recipe.ingredients.empty?
      flash.now[:ingredient] = "材料がまだ入力されていません。確認して下さい"
    end
    if @recipe.cookings.empty?
      flash.now[:cooking] = "作り方がまだ入力されていません。確認して下さい"
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    # 材料編集、作り方編集画面からのrecipe_statusを完成にするためのform_with
    if params[:recipe_status]
      if @recipe.ingredients.empty?
        redirect_to recipe_path(@recipe)
        flash[:ingredient] = "材料が入力されていないため投稿できません。確認して下さい"
      elsif @recipe.cookings.empty?
        redirect_to recipe_path(@recipe)
        flash[:cooking] = "作り方が入力されていないため投稿できません。確認して下さい"
      else
        @recipe.update(recipe_params)
        redirect_to recipe_path(@recipe)
        flash[:create] = "YOUR RECIPE RELEASE !"
      end
    else
      # レシピ名などの更新
      if @recipe.update(recipe_params)
        flash[:create] = "UPDATE !"
        redirect_to recipe_path(@recipe)
      else
        @recipe = Recipe.find(params[:id])
        flash.now[:notice] = "正しく入力ができていません。もう一度入力して下さい"
        render ("recipes/edit")
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
