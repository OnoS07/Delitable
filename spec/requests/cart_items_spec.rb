require 'rails_helper'

RSpec.describe "CartItems", type: :request do
	before do
		@customer = create(:customer)
		sign_in @customer
		@product = create(:product)
	end
	it "カート内商品の新規作成ができる" do
		post customers_cart_items_path, params: { cart_item: FactoryBot.attributes_for(:cart_item) }
		expect(response).to have_http_status(302)
	end

	it "カート内商品の確認画面を表示できる" do
		get cart_item_confirm_path
		expect(response).to have_http_status(200)
	end

	context "カート内商品が必要なリクエスト" do
		before do
			@cart_item = create(:cart_item, customer_id: @customer.id, product_id: @product.id)
		end
		it "カート内商品を編集できる" do
			put customers_cart_item_path(@cart_item), params: { cart_item: FactoryBot.attributes_for(:cart_item) }
			expect(response).to redirect_to cart_item_confirm_path
		end
		it "カート内商品を削除できる" do
			delete customers_cart_item_path(@cart_item)
			expect(response).to redirect_to cart_item_confirm_path
		end
		it "カート内商品を全て削除できる" do
			delete cart_items_destroy_all_path
			expect(response).to redirect_to cart_item_confirm_path
		end
	end
end
