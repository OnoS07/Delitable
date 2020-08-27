require 'rails_helper'

RSpec.describe "CartItems", type: :request do
	before do
		@customer = create(:customer)
		@genre = create(:genre)
		@product = create(:product, genre_id: @genre.id)
		sign_in @customer
	end
	it "カート内商品の新規作成リクエストが成功する" do
		post customers_cart_items_path, params: { cart_item: FactoryBot.attributes_for(:cart_item) }
		expect(response).to have_http_status(302)
	end
	it "カート内商品が1件増える" do
        expect do
			post customers_cart_items_path, params: { cart_item: FactoryBot.attributes_for(:cart_item, customer_id: @customer.id, product_id: @product.id) }
        end.to change(CartItem, :count).by(1)
	end

	it "値が正しくない場合、カート内商品が新規作成されない" do
        expect do
          post customers_cart_items_path, params: { cart_item: FactoryBot.attributes_for(:cart_item, count: nil, customer_id: @customer.id, product_id: @product.id) }
        end.to_not change(CartItem, :count)
	end

	it "カート内商品の確認画面を表示できる" do
		get cart_item_confirm_path
		expect(response).to have_http_status(200)
	end

	context "カート内商品が必要なリクエスト" do
		before do
			@cart_item = create(:cart_item, customer_id: @customer.id, product_id: @product.id)
		end
		it "カート内商品の更新リクエストが成功する" do
			put customers_cart_item_path(@cart_item), params: { cart_item: FactoryBot.attributes_for(:cart_item) }
			expect(response).to redirect_to cart_item_confirm_path
		end
		it "カート内商品の個数が更新される" do
			expect do
				put customers_cart_item_path(@cart_item), params: { cart_item: FactoryBot.attributes_for(:cart_item, count: 2) }
			end.to change { CartItem.find(@cart_item.id).count }.from(@cart_item.count).to(2)
		end
		it "値が正しくない場合、カート内商品が更新されない" do
			expect do
				put customers_cart_item_path(@cart_item), params: { cart_item: FactoryBot.attributes_for(:cart_item, count: nil) }
			end.to_not change { CartItem.find(@cart_item.id).count }
		end

		it "カート内商品を削除リクエストが成功する" do
			delete customers_cart_item_path(@cart_item)
			expect(response).to redirect_to cart_item_confirm_path
		end
		it "カート内商品が1件減る" do
	        expect do
				delete customers_cart_item_path(@cart_item)
	        end.to change(CartItem, :count).by(-1)
		end
		it "カート内商品を全て削除リクエストが成功する" do
			delete cart_items_destroy_all_path
			expect(response).to redirect_to cart_item_confirm_path
		end
		it "カート内商品が0件になる" do
	        expect do
	        	@cart_item_2 = CartItem.create(count: 2, customer_id: @customer.id, product_id: @product.id)
				delete cart_items_destroy_all_path
	        end.to change(CartItem, :count).by(-(CartItem.all).count)
		end
	end
end
