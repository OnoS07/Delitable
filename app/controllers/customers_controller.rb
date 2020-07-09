class CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customer_path(current_customer)
  end

  def delete; end

  def destroy; end

  def customer_params
    params.require(:customer).permit(:name, :account_name, :profile_image_id, :tel, :postcode,
                                     :address, :email)
  end
end
