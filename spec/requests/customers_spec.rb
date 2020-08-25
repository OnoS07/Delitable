require 'rails_helper'
def current_customer
	@current_customer = @customer
end

RSpec.describe "Customers", type: :request do
	before(:each) do
	  	@customer = create(:customer)
 	end
	it "顧客詳細画面が表示される" do
		get customer_path(@customer)
		expect(response).to have_http_status(200)
	end

	it "顧客編集画面が表示される" do
		sign_in @customer
		get edit_customer_path(current_customer)
		expect(response).to have_http_status(200)
	end
end