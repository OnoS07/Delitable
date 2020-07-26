class ProductsController < ApplicationController
  def index
    @genres = Genre.all
    @search = Product.ransack(params[:q])
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @genre_products = Product.where(genre_id: @genre.id)
      @products = @genre_products.where(is_active: '販売中')
      @index_title = @genre.name
    elsif params[:q]
      @products = @search.result.where(is_active: '販売中')
      @index_title = 'Vegetables'
    else
      @products = Product.where(is_active: '販売中')
      @index_title = 'Vegetables'
    end
  end

  def show
    @genres = Genre.all
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
end
