class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:show]
  before_action :confirm_customer_shipping, only: [:new]
  def ensure_correct_customer
    @order = Order.find(params[:id])
    redirect_to root_path if current_customer.id != @order.customer_id
  end

  def confirm_customer_shipping
    if current_customer.address.blank? || current_customer.postcode.blank? ||
       current_customer.name.blank? || current_customer.tel.blank?
      redirect_to customer_path(current_customer)
      flash[:notice] = '注文には、名前・郵便番号・住所・電話番号の登録が必要です'
    end
  end

  def new
    @order = Order.new
    @shipping = Shipping.new
    @shippings = Shipping.where(customer_id: current_customer.id)
    if current_customer.cart_items.blank?
      redirect_to cart_item_confirm_path
      flash[:notice] = '購入する商品がカートに入っていません'
    end
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new
    @order.payment_method = params[:payment_method]

    if params[:order_address] == '1'
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.name
    elsif params[:order_address] == '2'
      if params[:select_address]
        @shipping = Shipping.find(params[:select_address])
        @order.postcode = @shipping.postcode
        @order.address = @shipping.address
        @order.name = @shipping.name
      else
        redirect_to new_customers_order_path
        flash[:notice] = '登録済み住所はありません'
      end
    else
      @order.postcode = params[:postcode]
      @order.address = params[:address]
      @order.name = params[:name]
      @shipping = Shipping.new
      @shipping.customer_id = current_customer.id
      @shipping.postcode = @order.postcode
      @shipping.address = @order.address
      @shipping.name = @order.name
      unless @shipping.save
        @shippings = Shipping.where(customer_id: current_customer.id)
        render action: :new
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
        order_detail = @order.order_details.new
        order_detail.product_id = cart_item.product_id
        order_detail.count = cart_item.count
        order_detail.price = cart_item.product.price
        order_detail.work_status = '着手不可'
        order_detail.save
        cart_item.destroy
      end
      redirect_to order_complete_path
    else
      redirect_to order_confirm_path
    end
  end

  def complete; end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(id: 'DESC').page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  private

  def order_params
    params.permit(:customer_id, :name, :postcode, :address, :postage,
                  :total_products_cost, :payment_method, :order_status)
  end
end
