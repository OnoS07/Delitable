class OrdersController < ApplicationController
  def new
    @order = Order.new
    @shipping = Shipping.where(customer_id: current_customer.id)
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new
    @order.payment_method = params[:payment_method]

    if params[:order_address] == '1' # 自分の住所選択
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.name
    elsif params[:order_address] == '2' # 配送先から選択
      @shipping = Shipping.find(params[:select_address])
      @order.postcode = @shipping.postcode
      @order.address = @shipping.address
      @order.name = @shipping.name
    else
      # params[:order_address] = '3' # 新しい配送先
      @order.postcode = params[:postcode]
      @order.address = params[:address]
      @order.name = params[:name]
      @shipping = Shipping.new
      @shipping.customer_id = current_customer.id
      @shipping.postcode = @order.postcode
      @shipping.address = @order.address
      @shipping.name = @order.name
      @shipping.save
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
        # cart_itemの中身を、order_detailに移す
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
    @orders = Order.where(customer_id: current_customer.id).order(id: 'DESC')
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
