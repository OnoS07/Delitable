class Admins::CustomersController < ApplicationController
  def index
  	@customers = Customer.all
  end

  def show
  	@customer = Customer.find(params[:id])
  end

  def edit
  	@customer = Customer.find(params[:id])
  end

  def update
   	@customer = Customer.find(params[:id])
  	@customer.update(customer_params)
  	redirect_to admins_customer_path(@customer)
  end

  def customer_params
    params.require(:customer).permit(:name, :account_name, :profile_image_id, :tel, :postcode,
                                     :address, :email)
  end
end
