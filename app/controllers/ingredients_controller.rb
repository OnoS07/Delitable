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
    @ingredients = @recipe.ingredients.all
  	if @ingredient.save
      # 1つ作成でステータス変更
      if @recipe.recipe_status == "レシピ"
        @recipe.update(recipe_status: "材料")
        # 未入力箇所の入力ができれば、ステータスを準備中に変更
      elsif @recipe.recipe_status == "未入力あり" and @recipe.cookings.present?
        @recipe.update(recipe_status: "準備中")
      end
    else
      redirect_to edit_recipe_ingredients_path(@recipe)
      flash[:notice] = "正しく入力ができていません。もう一度入力して下さい"
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = Ingredient.where(recipe_id: @recipe.id)
    @ingredient = Ingredient.new
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredients = @recipe.ingredients
    @recipe = Recipe.find(params[:recipe_id])
    if @ingredient.update(ingredient_params)
      flash.now[:update] = "UPDATE !"
    else
      flash.now[:notice] = "正しく入力ができていません。もう一度入力して下さい"
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
  	@ingredient = Ingredient.find(params[:id])
    @ingredients = @recipe.ingredients.all
  	if @ingredient.destroy
      # レシピ完成後、材料が全て削除されたらステータスを未入力ありにして公開停止
      if @recipe.ingredients.empty? and @recipe.recipe_status == "完成" or "準備中"
        @recipe.update(recipe_status: "未入力あり")
        flash.now[:notice] = "材料が入力されていません。確認して下さい"
      end
    end
  end

  private
  def ingredient_params
  	params.require(:ingredient).permit(:recipe_id, :content, :amount)
  end
end
