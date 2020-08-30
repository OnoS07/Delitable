require 'rails_helper'

RSpec.describe Review, type: :model do
  before(:each) do
    @customer = create(:customer)
    @genre = create(:genre)
    @product = create(:product, genre_id: @genre.id)
    @review = create(:review, customer_id: @customer.id, product_id: @product.id)
  end

  it 'レビューの作成ができる' do
    expect(@review).to be_valid
  end

  it 'レビュー本文がない場合、無効にする' do
    @review.content = nil
    @review.valid?
    expect(@review.errors[:content]).to include('を入力してください')
  end

  it '評価がない場合、無効にする' do
    @review.rate = nil
    @review.valid?
    expect(@review.errors[:rate]).to include('を入力してください')
  end
  it '評価が5以上の場合、無効にする' do
    @review.rate = 6
    @review.valid?
    expect(@review.errors[:rate]).to include('は5以下の値にしてください')
  end
end
