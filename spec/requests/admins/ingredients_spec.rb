require 'rails_helper'

RSpec.describe 'Admins::Ingredients', type: :request do
  before do
    @admin = create(:admin)
    @customer = create(:customer)
    @recipe = create(:recipe, customer_id: @customer.id)
    @ingredient = create(:ingredient, recipe_id: @recipe.id)
    sign_in @admin
  end
  it '材料の編集画面が表示できる' do
    get edit_admins_recipe_ingredient_path(@ingredient, @recipe)
    expect(response).to have_http_status(200)
  end
  it '材料の更新リクエストが成功する' do
    put admins_recipe_ingredient_path(@ingredient, @recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient, recipe_id: @recipe.id) }, xhr: true
    expect(response).to have_http_status(200)
  end
  it '材料の更新ができる' do
    expect do
      put admins_recipe_ingredient_path(@ingredient, @recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient, recipe_id: @recipe.id, content: 'update') }, xhr: true
    end.to change { Ingredient.find(@ingredient.id).content }.from(@ingredient.content).to('update')
  end
  it '値が正しくない場合、材料が更新されない' do
    expect do
      put admins_recipe_ingredient_path(@ingredient, @recipe), params: { ingredient: FactoryBot.attributes_for(:ingredient, recipe_id: @recipe.id, content: nil) }, xhr: true
    end.to_not change { Ingredient.find(@ingredient.id).content }
  end

  it '材料の削除リクエストが成功する' do
    delete admins_recipe_ingredient_path(@ingredient, @recipe), xhr: true
    expect(response).to have_http_status(200)
  end
  it '材料が1件減る' do
    expect do
      delete admins_recipe_ingredient_path(@ingredient, @recipe), xhr: true
    end.to change(Ingredient, :count).by(-1)
  end
end
