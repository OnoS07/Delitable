class CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_item_confirm_path
      flash[:create] = "NEW ITEM !"
    else
      redirect_back(fallback_location: root_path)
      flash[:notice] = "個数を選択して下さい"
    end
  end

  def confirm
    @cart_items = current_customer.cart_items.all
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:update] = "UPDATE !"
      redirect_to cart_item_confirm_path
    else
      flash[:notice] = "個数は半角数字で入力して下さい。1~10まで変更できます"
      redirect_to cart_item_confirm_path
    end
  end

  def destroy_all
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.destroy_all
    redirect_to cart_item_confirm_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_item_confirm_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :product_id, :count)
  end
end
