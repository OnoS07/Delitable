class Admins::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params_product)
    @product.save
    redirect_to admins_products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(params_product)
    redirect_to admins_product_path(@product)
  end

  def params_product
    params.require(:product).permit(:genre_id, :name, :price, :introduction,
                                    :product_image, :is_active)
  end
end
