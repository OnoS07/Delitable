require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @customer = create(:customer)
    @recipe = build(:recipe, customer_id: @customer.id)
  end
  it 'レシピの作成ができる' do
    expect(@recipe).to be_valid
  end

  it 'タイトルがない場合、無効にする' do
    @recipe.title = nil
    @recipe.valid?
    expect(@recipe.errors[:title]).to include('を入力してください')
  end
  it 'タイトルが30文字以上の場合、無効にする' do
    @recipe.title = 'a' * 31
    @recipe.valid?
    expect(@recipe.errors[:title]).to include('は30文字以内で入力してください')
  end

  it '紹介文がない場合、無効にする' do
    @recipe.introduction = nil
    @recipe.valid?
    expect(@recipe.errors[:introduction]).to include('を入力してください')
  end
  it '紹介文が200文字以上の場合、無効にする' do
    @recipe.introduction = 'a' * 201
    @recipe.valid?
    expect(@recipe.errors[:introduction]).to include('は200文字以内で入力してください')
  end

  it '分量がない場合、無効にする' do
    @recipe.amount = nil
    @recipe.valid?
    expect(@recipe.errors[:amount]).to include('を入力してください')
  end
  it '分量が10文字以上の場合、無効にする' do
    @recipe.amount = 'a' * 11
    @recipe.valid?
    expect(@recipe.errors[:amount]).to include('は10文字以内で入力してください')
  end

  context 'いいねメソッド' do
    before do
      @recipe = create(:recipe, customer_id: @customer.id)
      @favo_customer = Customer.create(account_name: 'favo', email: 'favo@test', password: 'favotest')
    end
    it '既にいいねをしているか' do
      @favorite = @favo_customer.favorites.create(recipe_id: @recipe.id)
      expect(@recipe.favorited_by?(@favo_customer)).to be_truthy
    end
    it 'まだいいねをしていない' do
      expect(@recipe.favorited_by?(@favo_customer)).to be_falsey
    end
  end
end
