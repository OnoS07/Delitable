class CartItemsController < ApplicationController
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_item_confirm_path
  end

  def confirm
    @cart_items = current_customer.cart_items.all
  end

  def update
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

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :product_id, :count)
  end

end
