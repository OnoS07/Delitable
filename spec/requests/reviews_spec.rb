require 'rails_helper'

RSpec.describe "Reviews", type: :request do
	before do
		@customer = create(:customer, name: "test", postcode: "1234567", address: "test", tel: "11122223333" )
		sign_in @customer
		@shipping = create(:shipping, customer_id: @customer.id)
		@product = create(:product)
		@cart_item = create(:cart_item, customer_id: @customer.id, product_id: @product.id)
		@order = create(:order, customer_id: @customer.id)
		@order_detail = create(:order_detail, order_id: @order.id, product_id: @product.id)
	end

	it "レビューを新規作成できる" do
		post product_reviews_path(@product), params: { review: FactoryBot.attributes_for(:review) }
		expect(response).to redirect_to product_path(@product)
	end
	it "レビューが1つ増えている" do
		expect do
			post product_reviews_path(@product), params: { review: FactoryBot.attributes_for(:review) }
		end.to change(Review, :count).by(1)
	end

	context "レビューが必要なリクエスト" do
		before do
			@review = create(:review, customer_id: @customer.id, product_id: @product.id)
		end
		it "レビューを削除できる" do
			delete product_review_path(@review, @product)
			expect(response).to have_http_status(302)
		end
		it "レビューが1つ減っている" do
			expect do
				delete product_review_path(@review, @product)
			end.to change(Review, :count).by(-1)
		end
	end
end