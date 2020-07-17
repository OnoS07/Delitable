class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
    @recipes = Recipe.where(customer_id: @customer.id)
    @open_recipes = @recipes.where(recipe_status: "完成")
    @close_recipes = @recipes.where.not(recipe_status: "完成")
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customer_path(current_customer)
  end

  def delete
  end

  def destroy
    @customer = current_customer
    @customer.update(is_active: "退会済")
    @customer.destroy
    redirect_to root_path
  end

  def customer_params
    params.require(:customer).permit(:name, :account_name, :profile_image, :tel, :postcode,
                                     :address, :email)
  end
end
