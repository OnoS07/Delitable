require 'rails_helper'

RSpec.describe "Products", type: :request do
	it "商品の一覧画面を表示" do
		get products_path
		expect(response).to have_http_status(200)
	end
	it "商品の詳細画面を表示" do
		@product = create(:product)
		get products_path(@product)
		expect(response).to have_http_status(200)
	end
end
