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

	it "材料の新規作成リクエストが成功する" do
		post recipe_ingredients_path(@recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient) }, xhr: true
		expect(response).to have_http_status(200)
	end
	it "材料が1件増える" do
        expect do
			post recipe_ingredients_path(@recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient, recipe_id: @recipe.id) }, xhr: true
        end.to change(Ingredient, :count).by(1)
	end
	it "値が正しくない場合、材料が新規作成されない" do
		expect do
			post recipe_ingredients_path(@recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient, recipe_id: @recipe.id, content: nil) }, xhr: true
		end.to_not change(Ingredient, :count)
	end

	context "材料が必要なリクエスト" do
		before do
			@ingredient = create(:ingredient, recipe_id: @recipe.id)
		end
		it "材料の削除ができる" do
			delete recipe_ingredient_path(@ingredient, @recipe), xhr: true
			expect(response).to have_http_status(200)
		end

		it "材料の更新リクエストが成功する" do
			put recipe_ingredient_path(@ingredient, @recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient, recipe_id: @recipe.id) }, xhr: true
			expect(response).to have_http_status(200)
		end
		it "材料の更新ができる" do
			expect do
				put recipe_ingredient_path(@ingredient, @recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient, recipe_id: @recipe.id, content: "update" ) }, xhr: true
			end.to change { Ingredient.find(@ingredient.id).content }.from(@ingredient.content).to("update")
		end
		it "値が正しくない場合、材料が更新されない" do
			expect do
				put recipe_ingredient_path(@ingredient, @recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient, recipe_id: @recipe.id, content: nil ) }, xhr: true
			end.to_not change { Ingredient.find(@ingredient.id).content }
		end

		it "材料の削除リクエストが成功する" do
			delete recipe_ingredient_path(@ingredient, @recipe), xhr: true
			expect(response).to have_http_status(200)
		end
		it "材料が1件減る" do
	        expect do
				delete recipe_ingredient_path(@ingredient, @recipe), xhr: true
	        end.to change(Ingredient, :count).by(-1)
		end
	end
end
