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
    @shipping = Shipping.new
  end

  def edit
    @shipping = Shipping.find(params[:id])
  end

  def create
    @shipping = Shipping.new(shipping_params)
    @shipping.customer_id = current_customer.id
    if @shipping.save
      redirect_to customers_shippings_path
      flash[:create] = "NEW SHIPPING ! "
    else
      redirect_to customers_shippings_path
      flash[:notice] = "正しく入力ができていません。もう一度入力して下さい"
    end
  end

  def update
    @shipping = Shipping.find(params[:id])
    @shipping.customer_id = current_customer.id
    if @shipping.update(shipping_params)
      redirect_to customers_shippings_path
      flash[:create] = "SHIPPING UPDATE ! "
    else
      redirect_to edit_customers_shipping_path(@shipping)
      flash[:notice] = "正しく入力ができていません。もう一度入力して下さい"
    end
  end

  def destroy
    @shipping = Shipping.find(params[:id])
    @shipping.destroy
    redirect_to customers_shippings_path
  end

  private

  def shipping_params
    params.require(:shipping).permit(:customer_id, :name, :postcode, :address)
  end
end
