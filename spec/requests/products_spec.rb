require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before do
    @genre = create(:genre)
  end
  it '商品の一覧画面を表示できる' do
    get products_path
    expect(response).to have_http_status(200)
  end
  it '商品の詳細画面を表示できる' do
    @product = create(:product, genre_id: @genre.id)
    get products_path(@product)
    expect(response).to have_http_status(200)
  end
end
