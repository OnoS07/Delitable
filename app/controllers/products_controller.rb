class ProductsController < ApplicationController
  def index
    @genres = Genre.all
    @search = Product.ransack(params[:q])
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @genre_products = Product.where(genre_id: @genre.id)
      @products = @genre_products.where(is_active: '販売中').page(params[:page]).per(16)
      @index_title = @genre.name
    elsif params[:q]
      @products = @search.result(distinct: true).where(is_active: '販売中').page(params[:page]).per(16)
      @index_title = 'Vegetables'
    else
      @products = Product.where(is_active: '販売中').page(params[:page]).per(16)
      @index_title = 'Vegetables'
    end
  end

  def show
    @genres = Genre.all
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
    if customer_signed_in?
      @review = Review.new
      order_ids = current_customer.orders.pluck(:id)
      @ordered = OrderDetail.where(order_id: order_ids).where(product_id: @product.id)
    end

    ingredients = Ingredient.where(content: @product.name)
    recipe_ids = ingredients.pluck(:recipe_id)
    @recipes = Recipe.where(recipe_status: '完成').where(id: recipe_ids)
  end
end
