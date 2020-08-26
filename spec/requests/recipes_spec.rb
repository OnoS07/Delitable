require 'rails_helper'

RSpec.describe "Recipes", type: :request do
	context "ログインが必要なリクエスト" do
		before do
		  	@customer = create(:customer)
			sign_in @customer
		end

		it "レシピの新規作成ページが表示できる" do
			get new_recipe_path
			expect(response).to have_http_status(200)
		end
		it "レシピの新規作成ができる" do
			post recipes_path, params: { recipe: FactoryBot.attributes_for(:recipe) }
			expect(response).to have_http_status(302)
		end

		context "レシピが必要なリクエスト" do
			before do
				@recipe = create(:recipe, customer_id: @customer.id)
			end

			it "レシピの詳細画面が表示できる" do
				get recipe_path(@recipe)
				expect(response).to have_http_status(200)
			end
			it "レシピの編集画面が表示できる" do
				get edit_recipe_path(@recipe)
				expect(response).to have_http_status(200)
			end
			it "レシピの編集ができる" do
				put recipe_path(@recipe), params: { recipe: FactoryBot.attributes_for(:recipe) }
				expect(response).to redirect_to recipe_path(@recipe)
			end

			it "レシピの削除ができる" do
				delete recipe_path(@recipe)
				expect(response).to redirect_to recipes_path
			end
		end
	end

	it "レシピの一覧画面が表示できる" do
		get recipes_path
		expect(response).to have_http_status(200)
	end
	it 'Recipesが表示されていること' do
      get recipes_path
	  expect(response.body).to include "Recipes"
    end
end
