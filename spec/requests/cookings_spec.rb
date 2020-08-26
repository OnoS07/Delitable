require 'rails_helper'

RSpec.describe "Cookings", type: :request do
	before do
		@customer = create(:customer)
		@recipe = create(:recipe, customer_id: @customer.id)
		sign_in @customer
	end
	it "作り方の編集画面が表示できる" do
		get edit_recipe_cookings_path(@recipe)
		expect(response).to have_http_status(200)
	end
	it "作り方の新規作成ができる" do
		post recipe_cookings_path(@recipe), params: { cooking: FactoryBot.attributes_for(:cooking) }, xhr: true
		expect(response).to have_http_status(200)
	end

	context "作り方が必要なリクエスト" do
		before do
			@cooking = create(:cooking, recipe_id: @recipe.id)
		end
		it "材料の削除ができる" do
			delete recipe_cooking_path(@cooking, @recipe), xhr: true
			expect(response).to have_http_status(200)
		end
	end
end
