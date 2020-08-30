require 'rails_helper'

RSpec.describe 'Admins::Orders', type: :request do
  before do
    @customer = create(:customer, name: 'test', postcode: '1234567', address: 'test', tel: '11122223333')
    @shipping = create(:shipping, customer_id: @customer.id)
    @genre = create(:genre)
    @product = create(:product, genre_id: @genre.id)
    @cart_item = create(:cart_item, customer_id: @customer.id, product_id: @product.id)
    @order = create(:order, customer_id: @customer.id)
    @order_detail = create(:order_detail, order_id: @order.id, product_id: @product.id)
    @admin = create(:admin)
    sign_in @admin
  end
  it '注文のトップ画面が表示できる' do
    get admins_top_path
    expect(response).to have_http_status(200)
  end
  it '注文の一覧画面が表示できる' do
    get admins_orders_path
    expect(response).to have_http_status(200)
  end
  it '注文の詳細画面が表示できる' do
    get admins_order_path(@order)
    expect(response).to have_http_status(200)
  end

  it '注文の更新リクエストが成功する' do
    put admins_order_path(@order), params: { order: FactoryBot.attributes_for(:order) }
    expect(response).to have_http_status(302)
  end
  it '注文の更新ができる' do
    expect do
      put admins_order_path(@order), params: { order: FactoryBot.attributes_for(:order, order_status: '入金確認') }
    end.to change { Order.find(@order.id).order_status }.from(@order.order_status).to('入金確認')
  end
  it '値が正しくない場合、注文が更新されない' do
    expect do
      put admins_order_path(@order), params: { order: FactoryBot.attributes_for(:order, order_status: nil) }
    end.to_not change { Order.find(@order.id).order_status }
  end
end
