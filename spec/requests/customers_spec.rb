require 'rails_helper'

RSpec.describe "Customers", type: :request do
	before(:each) do
	  	@customer = create(:customer)
 	end
	it "顧客詳細画面が表示される" do
		get customer_path(@customer)
		expect(response).to have_http_status(200)
	end
	it "いいねしたレシピの一覧画面を表示できる" do
		get favorites_path(@customer)
		expect(response).to have_http_status(200)
	end

	context "ログインが必要なリクエスト" do
		before do
			sign_in @customer
		end
		it "顧客編集画面が表示される" do
			get edit_customer_path(@customer)
			expect(response).to have_http_status(200)
		end
		it "顧客情報の更新ができる" do
			put customer_path(@customer), params: { customer: FactoryBot.attributes_for(:customer) }
			expect(response).to redirect_to customer_path(@customer)
		end
		it "退会画面が表示できる" do
			get customers_delete_path
			expect(response).to have_http_status(200)
		end
		it "退会できる" do
			delete customer_path(@customer)
			expect(response).to redirect_to root_path
		end
	end
end