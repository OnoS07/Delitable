require 'rails_helper'

RSpec.describe "Orders", type: :request do
	before do
		@customer = create(:customer, name: "test", postcode: "1234567", address: "test", tel: "11122223333" )
		sign_in @customer
		@shipping = create(:shipping, customer_id: @customer.id)
		@genre = create(:genre)
		@product = create(:product, genre_id: @genre.id)
		@cart_item = create(:cart_item, customer_id: @customer.id, product_id: @product.id)
	end
	it "注文の新規作成画面が表示できる" do
		get new_customers_order_path
		expect(response).to have_http_status(200)
	end
	it "注文の確認画面が表示できる" do
		get order_confirm_path, params: {order_address: 1}
		expect(response).to have_http_status(200)
	end

	it "注文の新規作成のリクエストが成功する" do
		post customers_orders_path
		expect(response).to have_http_status(302)
	end
	it "値が正しくない場合、注文が新規作成されない" do
        expect do
			post customers_orders_path, params: { order: FactoryBot.attributes_for(:order, customer_id: @customer.id, postcode: 123456) }
        end.to_not change(Order, :count)
	end

	it "注文の完了画面が表示できる" do
		get order_complete_path
		expect(response).to have_http_status(200)
	end

	it "注文の一覧画面が表示できる" do
		get customers_orders_path
		expect(response).to have_http_status(200)
	end

	context "注文が必要なリクエスト" do
		before do
			@order = create(:order, customer_id: @customer.id)
			@order_detail = create(:order_detail, order_id: @order.id, product_id: @product.id)
		end
		it "注文の詳細画面が表示できる" do
			get customers_order_path(@order)
			expect(response).to have_http_status(200)
		end
	end
end
