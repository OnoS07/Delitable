class ShippingsController < ApplicationController
  def index
    @customer = current_customer
    @shippings = Shipping.where(customer_id: @customer.id)
  end

  def edit
    @shipping = Shipping.find(params[:id])
  end

  def create
    @shipping = Shipping.new(shipping_params_create)
    @shipping.customer_id = current_customer.id
    @shipping.save
    redirect_to customers_shippings_path
  end

  def update
    @shipping = Shipping.find(params[:id])
    @shipping.customer_id = current_customer.id
    @shipping.update(shipping_params_update)
    redirect_to customers_shippings_path
  end

  def destroy
    @shipping = Shipping.find(params[:id])
    @shipping.destroy
    redirect_to customers_shippings_path
  end

  private
  def shipping_params_update
    params.require(:shipping).permit(:customer_id, :name, :postcode, :address)
  end

  def shipping_params_create
    params.permit(:customer_id, :name, :postcode, :address)
  end
end
