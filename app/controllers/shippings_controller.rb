class ShippingsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: %i[edit destroy]
  def ensure_correct_customer
    @shipping = Shipping.find(params[:id])
    redirect_to root_path if current_customer.id != @shipping.customer_id
  end

  def index
    @customer = current_customer
    @shippings = Shipping.where(customer_id: @customer.id).page(params[:page]).per(10)
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
      flash[:create] = 'NEW SHIPPING ! '
    else
      @shippings = Shipping.where(customer_id: current_customer.id)
      flash.now[:notice] = '正しく入力ができていません。もう一度入力して下さい'
      render 'shippings/index'
    end
  end

  def update
    @shipping = Shipping.find(params[:id])
    @shipping.customer_id = current_customer.id
    if @shipping.update(shipping_params)
      redirect_to customers_shippings_path
      flash[:create] = 'UPDATE ! '
    else
      @shipping = Shipping.find(params[:id])
      flash.now[:notice] = '正しく入力ができていません。もう一度入力して下さい'
      render 'shippings/edit'
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
