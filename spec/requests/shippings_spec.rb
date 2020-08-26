require 'rails_helper'

RSpec.describe "Shippings", type: :request do
	before do
		@customer = create(:customer)
		sign_in @customer
	end
	it "配送先の一覧画面が表示できる" do
		get customers_shippings_path(@customer)
		expect(response).to have_http_status(200)
	end
	it "配送先の新規作成ができる" do
		post customers_shippings_path, params: { shipping: FactoryBot.attributes_for(:shipping) }
		expect(response).to have_http_status(302)
	end

	context "配送先が必要なリクエスト" do
		before do
			@shipping = create(:shipping, customer_id: @customer.id)
		end

		it "配送先の編集画面が表示できる" do
			get edit_customers_shipping_path(@shipping)
			expect(response).to have_http_status(200)
		end
		it "配送先の編集ができる" do
			put customers_shipping_path(@shipping), params: { shipping: FactoryBot.attributes_for(:shipping) }
			expect(response).to redirect_to customers_shippings_path
		end
		it "配送先の削除ができる" do
			delete customers_shipping_path(@shipping)
			expect(response).to redirect_to customers_shippings_path
		end
	end
end
