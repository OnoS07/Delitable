class Admins::OrdersController < ApplicationController
  def top
  	@orders = Order.all
  end

  def index
  	if params[:customer_id]
		@customer = Customer.find(params[:customer_id])
		@orders = Order.where(customer_id: @customer.id)
		@order_title = "注文一覧/" + @customer.name
  	else
  		@orders = Order.all
  		@order_title = "注文一覧"
  	end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @order.update(order_params)
    if @order.order_status == "入金確認"
      @order_details.each do |order_detail|
        order_detail.update(work_status: "準備待ち")
      end
    end
    redirect_to admins_order_path(@order)
  end

  def order_params
    params.require(:order).permit(:order_status)
  end
end
