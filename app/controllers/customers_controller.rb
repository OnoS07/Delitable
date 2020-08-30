class CustomersController < ApplicationController
  before_action :authenticate_customer!, only: %i[delete update edit destroy delete]

  def show
    @customer = Customer.find(params[:id])
    @recipes = Recipe.where(customer_id: @customer.id)
    @open_recipes = @recipes.where(recipe_status: '完成')
    @close_recipes = @recipes.where.not(recipe_status: '完成')
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer)
      flash[:update] = 'PROFILE UPDATE ! '
    else
      redirect_to edit_customer_path(current_customer)
      flash[:notice] = '正しく入力ができていません。もう一度入力して下さい'
    end
  end

  def delete; end

  def destroy
    @customer = current_customer
    @customer.update(is_active: '退会済')
    @customer.destroy
    redirect_to root_path
  end

  def favorite_index
    @customer = Customer.find(params[:id])
    all_recipe = Recipe.where(recipe_status: '完成')
    recipe_ids = all_recipe.pluck(:id)
    recipe_favorites = Favorite.where(recipe_id: recipe_ids)
    @favorites = recipe_favorites.where(customer_id: params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :account_name, :profile_image, :tel, :postcode,
                                     :address, :email, :is_active, :introduction)
  end
end
