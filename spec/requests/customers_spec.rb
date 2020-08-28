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
		it "顧客情報の更新リクエストが成功する" do
			put customer_path(@customer), params: { customer: FactoryBot.attributes_for(:customer) }
			expect(response).to redirect_to customer_path(@customer)
		end
		it "顧客情報が更新される" do
			expect do
				put customer_path(@customer), params: { customer: FactoryBot.attributes_for(:customer, account_name: "update_name") }
			end.to change { Customer.find(@customer.id).account_name }.from(@customer.account_name).to("update_name")
		end
		it "値が正しくない場合、顧客情報が更新されない" do
			expect do
				put customer_path(@customer), params: { customer: FactoryBot.attributes_for(:customer, name: nil) }
			end.to_not change { Customer.find(@customer.id).account_name }
		end


		it "退会画面が表示できる" do
			get customers_delete_path
			expect(response).to have_http_status(200)
		end
		it "退会できる" do
			expect do
				delete customer_path(@customer)
			end.to change { Customer.with_deleted.find(@customer.id).is_active }.from(@customer.is_active).to("退会済")
		end
	end
end