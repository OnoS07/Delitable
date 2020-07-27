class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def top
    @orders = Order.where(created_at: Time.zone.now.all_day)
  end

  def index
    @search = Order.ransack(params[:q])
    if params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @orders = Order.where(customer_id: @customer.id).order(id: 'DESC')
      @order_title = '注文一覧/' + @customer.name + ' 様'
    elsif params[:q]
      # キーワード検索時
      @orders = @search.result(distinct: true)
      @order_title = '注文一覧/検索：' + @search.name_or_address_or_customer_name_cont
    else
      @orders = Order.all.order(id: 'DESC')
      @order_title = '注文一覧'
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
    if @order.order_status == '入金確認'
      @order_details.each do |order_detail|
        order_detail.update(work_status: '準備待ち')
      end
    end
    redirect_to admins_order_path(@order)
  end

  def order_params
    params.require(:order).permit(:order_status)
  end
end
