class ShippingsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :destroy]
  def ensure_correct_customer
    @shipping = Shipping.find(params[:id])
    if current_customer.id != @shipping.customer_id
      redirect_to root_path
    end
  end

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
