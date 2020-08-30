require 'rails_helper'

RSpec.describe 'Cookings', type: :request do
  before do
    @customer = create(:customer)
    @recipe = create(:recipe, customer_id: @customer.id)
    sign_in @customer
  end
  it '作り方の編集画面が表示できる' do
    get edit_recipe_cookings_path(@recipe)
    expect(response).to have_http_status(200)
  end

  it '作り方の新規作成リクエストが成功する' do
    post recipe_cookings_path(@recipe), params: { cooking: FactoryBot.attributes_for(:cooking) }, xhr: true
    expect(response).to have_http_status(200)
  end
  it '作り方が1件増える' do
    expect do
      post recipe_cookings_path(@recipe), params: { cooking: FactoryBot.attributes_for(:cooking, recipe_id: @recipe.id) }, xhr: true
    end.to change(Cooking, :count).by(1)
  end
  it '値が正しくない場合、作り方が新規作成されない' do
    expect do
      post recipe_cookings_path(@recipe), params: { cooking: FactoryBot.attributes_for(:cooking, recipe_id: @recipe.id, content: nil) }, xhr: true
    end.to_not change(Cooking, :count)
  end

  context '作り方が必要なリクエスト' do
    before do
      @cooking = create(:cooking, recipe_id: @recipe.id)
    end
    it '作り方の更新リクエストが成功する' do
      put recipe_cooking_path(@cooking, @recipe), params: { cooking: FactoryBot.attributes_for(:cooking, recipe_id: @recipe.id) }, xhr: true
      expect(response).to have_http_status(200)
    end
    it '作り方の更新ができる' do
      expect do
        put recipe_cooking_path(@cooking, @recipe), params: { cooking: FactoryBot.attributes_for(:cooking, recipe_id: @recipe.id, content: 'update') }, xhr: true
      end.to change { Cooking.find(@cooking.id).content }.from(@cooking.content).to('update')
    end
    it '値が正しくない場合、作り方が更新されない' do
      expect do
        put recipe_cooking_path(@cooking, @recipe), params: { cooking: FactoryBot.attributes_for(:cooking, recipe_id: @recipe.id, content: nil) }, xhr: true
      end.to_not change { Cooking.find(@cooking.id).content }
    end

    it '作り方の削除リクエストが成功する' do
      delete recipe_cooking_path(@cooking, @recipe), xhr: true
      expect(response).to have_http_status(200)
    end
    it '作り方が1件減る' do
      expect do
        delete recipe_cooking_path(@cooking, @recipe), xhr: true
      end.to change(Cooking, :count).by(-1)
    end
  end
end
