require 'rails_helper'

RSpec.describe "Admins::OrderDetails", type: :request do
	before do
		@customer = create(:customer, name: "test", postcode: "1234567", address: "test", tel: "11122223333" )
		@shipping = create(:shipping, customer_id: @customer.id)
		@genre = create(:genre)
		@product = create(:product, genre_id: @genre.id)
		@cart_item = create(:cart_item, customer_id: @customer.id, product_id: @product.id)
		@order = create(:order, customer_id: @customer.id)
		@order_detail = create(:order_detail, order_id: @order.id, product_id: @product.id)
		@admin = create(:admin)
		sign_in @admin
	end
	it "注文詳細の更新リクエストが成功する" do
		put admins_order_detail_path(@order_detail), params: { order_detail: FactoryBot.attributes_for(:order_detail) }
		expect(response).to have_http_status(302)
	end
	it "注文詳細の更新ができる" do
		expect do
			put admins_order_detail_path(@order_detail), params: { order_detail: FactoryBot.attributes_for(:order_detail, work_status: "準備待ち") }
		end.to change { OrderDetail.find(@order_detail.id).work_status }.from(@order_detail.work_status).to("準備待ち")
	end
	it "値が正しくない場合、注文詳細が更新されない" do
		expect do
			put admins_order_detail_path(@order_detail), params: { order_detail: FactoryBot.attributes_for(:order_detail, work_status: nil) }
		end.to_not change { OrderDetail.find(@order_detail.id).work_status }
	end
end
