require 'rails_helper'

RSpec.describe "Ingredients", type: :request do
	before do
		@customer = create(:customer)
		@recipe = create(:recipe, customer_id: @customer.id)
		sign_in @customer
	end
	it "材料の編集画面が表示できる" do
		get edit_recipe_ingredients_path(@recipe)
		expect(response).to have_http_status(200)
	end
	it "材料の新規作成ができる" do
		post recipe_ingredients_path(@recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient) }, xhr: true
		expect(response).to have_http_status(200)
	end

	context "材料が必要なリクエスト" do
		before do
			@ingredient = create(:ingredient, recipe_id: @recipe.id)
		end
		it "材料の削除ができる" do
			delete recipe_ingredient_path(@ingredient, @recipe), xhr: true
			expect(response).to have_http_status(200)
		end
	end
end
