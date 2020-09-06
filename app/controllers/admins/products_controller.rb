class Admins::ProductsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @search = Product.ransack(params[:q])
    if params[:q]
      @products = @search.result(distinct: true).page(params[:page]).per(15)
      @product_title = '商品一覧/検索：' + @search.name_or_introduction_or_genre_name_cont
    else
      @products = Product.page(params[:page]).per(15)
      @product_title = '商品一覧'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params_product)
    if @product.save
      redirect_to admins_products_path
    else
      flash.now[:notice] = '正しく入力ができていません。もう一度入力して下さい'
      render action: :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(params_product)
      redirect_to admins_product_path(@product)
    else
      flash.now[:notice] = '正しく入力ができていません。もう一度入力して下さい'
      render action: :edit
    end
  end

  def reviews
    @reviews = Review.all
  end

  def params_product
    params.require(:product).permit(:genre_id, :name, :price, :introduction,
                                    :product_image, :is_active)
  end
end
