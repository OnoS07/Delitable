require 'rails_helper'

RSpec.describe "Reviews", type: :request do
	before do
		@customer = create(:customer, name: "test", postcode: "1234567", address: "test", tel: "11122223333" )
		sign_in @customer
		@shipping = create(:shipping, customer_id: @customer.id)
		@genre = create(:genre)
		@product = create(:product, genre_id: @genre.id)
		@cart_item = create(:cart_item, customer_id: @customer.id, product_id: @product.id)
		@order = create(:order, customer_id: @customer.id)
		@order_detail = create(:order_detail, order_id: @order.id, product_id: @product.id)
	end

	it "レビューの新規作成リクエストが成功する" do
		post product_reviews_path(@product), params: { review: FactoryBot.attributes_for(:review) }
		expect(response).to have_http_status(302)
	end
	it "レビューが1件増える" do
		expect do
			post product_reviews_path(@product), params: { review: FactoryBot.attributes_for(:review) }
		end.to change(Review, :count).by(1)
	end
	it "値が正しくない場合、レビューが新規作成されない" do
        expect do
          post product_reviews_path(@product), params: { review: FactoryBot.attributes_for(:review, rate: nil) }
        end.to_not change(Review, :count)
	end

	context "レビューが必要なリクエスト" do
		before do
			@review = create(:review, customer_id: @customer.id, product_id: @product.id)
		end
		it "レビューの削除リクエストが成功する" do
			delete product_review_path(@review, @product)
			expect(response).to have_http_status(302)
		end
		it "レビューが1件減る" do
			expect do
				delete product_review_path(@review, @product)
			end.to change(Review, :count).by(-1)
		end
	end
end