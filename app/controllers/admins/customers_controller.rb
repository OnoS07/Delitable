class Admins::CustomersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @search = Customer.with_deleted.ransack(params[:q])
    if params[:q]
      # キーワード検索時
      @customers = @search.result(distinct: true)
      @customer_title = '顧客一覧/検索：' + @search.name_or_account_name_or_introduction_cont
    else
      @customers = Customer.with_deleted.all
      @customer_title = '顧客一覧'
    end
  end

  def show
    @customer = Customer.with_deleted.find(params[:id])
  end

  def edit
    @customer = Customer.with_deleted.find(params[:id])
  end

  def update
    @customer = Customer.with_deleted.find(params[:id])
    if @customer.update(customer_params)
      if @customer.is_active == '退会済'
        @customer.destroy
      elsif @customer.is_active == '有効'
        @customer.restore
      end
    end
    redirect_to admins_customer_path(@customer)
  end

  def customer_params
    params.require(:customer).permit(:name, :account_name, :profile_image_id, :tel, :postcode,
                                     :address, :email, :is_active, :introduction)
  end
end
