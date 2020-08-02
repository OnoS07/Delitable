class ProductsController < ApplicationController
  def index
    @genres = Genre.all
    @search = Product.ransack(params[:q])
    if params[:genre_id]
      # ジャンル検索時
      @genre = Genre.find(params[:genre_id])
      @genre_products = Product.where(genre_id: @genre.id)
      @products = @genre_products.where(is_active: '販売中')
      @index_title = @genre.name
    elsif params[:q]
      # キーワード検索時
      @products = @search.result(distinct: true).where(is_active: '販売中')
      @index_title = 'Vegetables'
    else
      # 通常の一覧
      @products = Product.where(is_active: '販売中')
      @index_title = 'Vegetables'
    end
  end

  def show
    @genres = Genre.all
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
    if customer_signed_in?
      @review = Review.new
      # 注文の中からorder.idだけ配列で取得
      order_ids = current_customer.orders.pluck(:id)
      # 1、配列で取ってきたorder.idと同じorder_idを取得
      # 2、その中からproduct_idが@productと同じものを探す。あれば配列を、なければ空配列を返す
      @ordered = OrderDetail.where(order_id: order_ids).where(product_id: @product.id)
    end
  end

end
