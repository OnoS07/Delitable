require 'rails_helper'

RSpec.describe 'Admins::Cookings', type: :request do
  before do
    @admin = create(:admin)
    @customer = create(:customer)
    @recipe = create(:recipe, customer_id: @customer.id)
    @cooking = create(:cooking, recipe_id: @recipe.id)
    sign_in @admin
  end
  it '作り方の編集画面が表示できる' do
    get edit_admins_recipe_cooking_path(@cooking, @recipe)
    expect(response).to have_http_status(200)
  end

  it '作り方の更新リクエストが成功する' do
    put admins_recipe_cooking_path(@cooking, @recipe), params: { cooking: FactoryBot.attributes_for(:cooking, recipe_id: @recipe.id) }
    expect(response).to have_http_status(302)
  end
  it '作り方の更新ができる' do
    expect do
      put admins_recipe_cooking_path(@cooking, @recipe), params: { cooking: FactoryBot.attributes_for(:cooking, recipe_id: @recipe.id, content: 'update') }
    end.to change { Cooking.find(@cooking.id).content }.from(@cooking.content).to('update')
  end
  it '値が正しくない場合、作り方が更新されない' do
    expect do
      put admins_recipe_cooking_path(@cooking, @recipe), params: { cooking: FactoryBot.attributes_for(:cooking, recipe_id: @recipe.id, content: nil) }
    end.to_not change { Cooking.find(@cooking.id).content }
  end
end
