require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  before do
    @customer = create(:customer)
    @recipe = create(:recipe, customer_id: @customer.id)
    sign_in @customer
  end

  it 'いいねをするリクエストが成功する' do
    post recipe_favorites_path(@recipe), xhr: true
    expect(response).to have_http_status(200)
  end
  it 'いいねが1つ増える' do
    expect do
      post recipe_favorites_path(@recipe), xhr: true
    end.to change(Favorite, :count).by(1)
  end

  context 'いいね後のリクエスト' do
    before do
      post recipe_favorites_path(@recipe), xhr: true
    end
    it 'いいねを削除するリクエストが成功する' do
      delete recipe_favorites_path(@recipe), xhr: true
      expect(response).to have_http_status(200)
    end
    it 'いいねが1つ減る' do
      expect do
        delete recipe_favorites_path(@recipe), xhr: true
      end.to change(Favorite, :count).by(-1)
    end
  end
end
