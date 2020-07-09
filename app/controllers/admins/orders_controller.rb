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

  def show; end

  def update; end
end
