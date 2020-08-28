require 'rails_helper'

RSpec.describe "Admins::Products", type: :request do
	before do
		@genre = create(:genre)
		@admin = create(:admin)
		sign_in @admin
	end
	it "商品の一覧画面が表示できる" do
		get admins_products_path
		expect(response).to have_http_status(200)
	end

	it "商品の新規作成画面が表示できる" do
		get new_admins_product_path
		expect(response).to have_http_status(200)
	end
	it "商品の新規作成リクエストが成功する" do
		post admins_products_path, params: { product: FactoryBot.attributes_for(:product, genre_id: @genre.id) }
		expect(response).to have_http_status(302)
	end
	it "商品が1件増える" do
		expect do
			post admins_products_path, params: { product: FactoryBot.attributes_for(:product, genre_id: @genre.id) }
		end.to change(Product, :count).by(1)
	end
	it "値が正しくない場合、商品が新規作成されない" do
		expect do
			post admins_products_path, params: { product: FactoryBot.attributes_for(:product, genre_id: @genre.id, name: nil) }
		end.to_not change(Product, :count)
	end

	it "レビュー一覧画面が表示される" do
		get admins_reviews_path
		expect(response).to have_http_status(200)
	end

	context "商品が必要なリクエスト" do
		before do
			@product = create(:product, genre_id: @genre.id)
		end
		it "商品の詳細画面が表示できる" do
			get admins_product_path(@product)
			expect(response).to have_http_status(200)
		end

		it "商品の編集画面が表示できる" do
			get edit_admins_product_path(@product)
			expect(response).to have_http_status(200)
		end

		it "商品の更新リクエストが成功する" do
			put admins_product_path(@genre), params: { product: FactoryBot.attributes_for(:product, genre_id: @genre.id) }
			expect(response).to have_http_status(302)
		end
		it "商品の更新ができる" do
			expect do
				put admins_product_path(@product), params: { product: FactoryBot.attributes_for(:product, genre_id: @genre.id, name: "update") }
			end.to change { Product.find(@product.id).name }.from(@product.name).to("update")
		end
		it "値が正しくない場合、商品が更新されない" do
			expect do
				put admins_product_path(@product), params: { product: FactoryBot.attributes_for(:product, genre_id: @genre.id, name: nil) }
			end.to_not change { Product.find(@product.id).name }
		end
	end
end
