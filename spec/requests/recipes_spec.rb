require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  it 'レシピの一覧画面が表示できる' do
    get recipes_path
    expect(response).to have_http_status(200)
  end

  context 'ログインが必要なリクエスト' do
    before do
      @customer = create(:customer)
      sign_in @customer
    end

    it 'レシピの新規作成ページが表示できる' do
      get new_recipe_path
      expect(response).to have_http_status(200)
    end
    it 'レシピの新規作成リクエストが成功する' do
      post recipes_path, params: { recipe: FactoryBot.attributes_for(:recipe) }
      expect(response).to have_http_status(302)
    end
    it 'レシピが1件増える' do
      expect do
        post recipes_path, params: { recipe: FactoryBot.attributes_for(:recipe) }
      end.to change(Recipe, :count).by(1)
    end

    it '値が正しくない場合、レシピが新規作成されない' do
      expect do
        post recipes_path, params: { recipe: FactoryBot.attributes_for(:recipe, title: nil) }
      end.to_not change(Recipe, :count)
    end

    context 'レシピが必要なリクエスト' do
      before do
        @recipe = create(:recipe, customer_id: @customer.id)
      end

      it 'レシピの詳細画面が表示できる' do
        get recipe_path(@recipe)
        expect(response).to have_http_status(200)
      end

      it 'レシピの編集画面が表示できる' do
        get edit_recipe_path(@recipe)
        expect(response).to have_http_status(200)
      end
      it 'レシピの更新リクエストが成功する' do
        put recipe_path(@recipe), params: { recipe: FactoryBot.attributes_for(:recipe) }
        expect(response).to have_http_status(302)
      end
      it 'レシピの更新ができる' do
        expect do
          put recipe_path(@recipe), params: { recipe: FactoryBot.attributes_for(:recipe, title: 'update-title') }
        end.to change { Recipe.find(@recipe.id).title }.from(@recipe.title).to('update-title')
      end
      it '値が正しくない場合、レシピが更新されない' do
        expect do
          put recipe_path(@recipe), params: { recipe: FactoryBot.attributes_for(:recipe, title: nil) }
        end.to_not change { Recipe.find(@recipe.id).title }
      end

      it 'レシピの削除リクエストが成功する' do
        delete recipe_path(@recipe)
        expect(response).to have_http_status(302)
      end
      it 'レシピが1件減る' do
        expect do
          delete recipe_path(@recipe)
        end.to change(Recipe, :count).by(-1)
      end
    end
  end
end
