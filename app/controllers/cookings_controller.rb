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
  	if @cooking.save
      if @recipe.recipe_status == "材料"
        @recipe.update(recipe_status: "作り方")
      elsif @recipe.recipe_status == "未入力あり" and @recipe.ingredients.present?
        @recipe.update(recipe_status: "完成")
      end
    else
      redirect_to edit_recipe_cookings_path(@recipe)
      flash[:notice] = "正しく入力ができていません。もう一度入力して下さい"
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @cooking = Cooking.new
    @cookings = Cooking.where(recipe_id: @recipe.id)
    if params[:flash]
      if @recipe.ingredients.present?
        flash[:create] = "NEW INGREDIENT CREATE !"
      else
        redirect_to edit_recipe_ingredients_path(@recipe)
        flash[:notice] = "材料が未入力です。"
      end
    end
  end

  def update
    @cooking = Cooking.find(params[:id])
    @cookings = @recipe.cookings.all
    @recipe = Recipe.find(params[:recipe_id])
    if @cooking.update(cooking_params)
      flash.now[:update] = "UPDATE !"
    else
      flash.now[:notice] = "正しく入力ができていません。もう一度入力して下さい"
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
  	@cooking = Cooking.find(params[:id])
    @cookings = @recipe.cookings.all
    if @cooking.destroy
       if @recipe.cookings.empty?
        if @recipe.recipe_status == "完成" or "未入力あり"
          @recipe.update(recipe_status: "未入力あり")
          flash.now[:notice] = "作り方が入力されていません。確認して下さい"
        end
       end
    end
  end

  private
  def cooking_params
  	params.require(:cooking).permit(:recipe_id, :cooking_image, :content)
  end

end
