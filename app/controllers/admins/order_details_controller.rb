class Admins::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(@order_detail.order_id)
    @all_order_details = OrderDetail.where(order_id: @order.id)
    @complete_work_status = @all_order_details.where(work_status: '準備完了')
    @order_detail.update(order_detail_params)
    @order.update(order_status: '商品準備中') if @order_detail.work_status == '商品準備中'
    @order.update(order_status: '発送準備中') if @all_order_details.count == @complete_work_status.count
    redirect_to admins_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:work_status)
  end
end
