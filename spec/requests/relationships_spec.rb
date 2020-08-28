require 'rails_helper'

RSpec.describe "Relationships", type: :request do
	before do
		@customer = create(:customer)
		@followed = Customer.create(account_name: "followed", email: "follow@test", password: "followtest")
		sign_in @customer
	end
	it "フォローの一覧画面が表示できる" do
		get customer_follows_path(@customer)
		expect(response).to have_http_status(200)
	end
	it "フォロワーの一覧画面が表示できる" do
		get customer_followers_path(@customer)
		expect(response).to have_http_status(200)
	end

	it "フォローのリクエストが成功する" do
		post customer_relationships_path(@followed), xhr: true
		expect(response).to have_http_status(200)
	end
	it "フォローが1件増える" do
		expect do
			post customer_relationships_path(@followed), xhr: true
		end.to change(Relationship, :count).by(1)
	end
	it "フォロー後、ボタンにフォローをやめるが表示されている" do
		post customer_relationships_path(@followed), xhr: true
		expect(response.body).to include "フォローをやめる"
	end

	context "フォロー後のリクエスト" do
		before do
			post customer_relationships_path(@followed), xhr: true
		end
		it "フォロー解除のリクエストが成功する" do
			delete customer_relationships_path(@followed), xhr: true
			expect(response).to have_http_status(200)
		end
		it "フォローが1件減る" do
			expect do
				delete customer_relationships_path(@followed), xhr: true
			end.to change(Relationship, :count).by(-1)
		end
		it "フォローの解除後、ボタンにフォローするが表示されている" do
			delete customer_relationships_path(@followed), xhr: true
			expect(response.body).to include "フォローする"
		end
	end
end
