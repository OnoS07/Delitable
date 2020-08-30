require 'rails_helper'

RSpec.describe 'Admins::Recipes', type: :request do
  before do
    @admin = create(:admin)
    @customer = create(:customer)
    @recipe = create(:recipe, customer_id: @customer.id)
    sign_in @admin
  end
  it 'レシピの一覧画面が表示できる' do
    get admins_recipes_path
    expect(response).to have_http_status(200)
  end
  it 'レシピの詳細画面が表示できる' do
    get admins_recipe_path(@recipe)
    expect(response).to have_http_status(200)
  end

  it 'レシピの編集画面が表示できる' do
    get edit_admins_recipe_path(@recipe)
    expect(response).to have_http_status(200)
  end
  it 'レシピの更新リクエストが成功する' do
    put admins_recipe_path(@recipe), params: { recipe: FactoryBot.attributes_for(:recipe) }
    expect(response).to have_http_status(302)
  end
  it 'レシピの更新ができる' do
    expect do
      put admins_recipe_path(@recipe), params: { recipe: FactoryBot.attributes_for(:recipe, title: 'update-title') }
    end.to change { Recipe.find(@recipe.id).title }.from(@recipe.title).to('update-title')
  end
  it '値が正しくない場合、レシピが更新されない' do
    expect do
      put admins_recipe_path(@recipe), params: { recipe: FactoryBot.attributes_for(:recipe, title: nil) }
    end.to_not change { Recipe.find(@recipe.id).title }
  end

  it 'レシピの削除リクエストが成功する' do
    delete admins_recipe_path(@recipe)
    expect(response).to have_http_status(302)
  end
  it 'レシピが1件減る' do
    expect do
      delete admins_recipe_path(@recipe)
    end.to change(Recipe, :count).by(-1)
  end
end
