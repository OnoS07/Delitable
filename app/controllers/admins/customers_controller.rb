class Admins::CustomersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @customers = Customer.with_deleted.all
  end

  def show
    @customer = Customer.with_deleted.find(params[:id])
  end

  def edit
    @customer = Customer.with_deleted.find(params[:id])
  end

  def update
    @customer = Customer.with_deleted.find(params[:id])
    @customer.update(customer_params)
    @customer.destroy if @customer.is_active == '退会済'
    redirect_to admins_customer_path(@customer)
  end

  def customer_params
    params.require(:customer).permit(:name, :account_name, :profile_image_id, :tel, :postcode,
                                     :address, :email, :is_active, :introduction)
  end
end
