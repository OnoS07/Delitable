class CartItemsController < ApplicationController
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to customer_cart_item_confirm_path
  end

  def confirm
  end

  def update
  end



  def destroy
  end

  def destroy_all
  end

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :product_id, :count)
  end

end
