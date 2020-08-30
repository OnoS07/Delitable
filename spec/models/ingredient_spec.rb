require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before(:each) do
    @customer = create(:customer)
    @recipe = create(:recipe, customer_id: @customer.id)
    @ingredient = build(:ingredient, recipe_id: @recipe.id)
  end

  it '材料の作成ができる' do
    expect(@ingredient).to be_valid
  end
  it '材料本文がない場合、無効にする' do
    @ingredient.content = nil
    @ingredient.valid?
    expect(@ingredient.errors[:content]).to include('を入力してください')
  end
  it '作り方本文が20文字以上の場合、無効にする' do
    @ingredient.content = 'a' * 21
    @ingredient.valid?
    expect(@ingredient.errors[:content]).to include('は20文字以内で入力してください')
  end

  it '分量がない場合、無効にする' do
    @ingredient.amount = nil
    @ingredient.valid?
    expect(@ingredient.errors[:amount]).to include('を入力してください')
  end
  it '分量が10文字以上の場合、無効にする' do
    @ingredient.amount = 'a' * 11
    @ingredient.valid?
    expect(@ingredient.errors[:amount]).to include('は10文字以内で入力してください')
  end
end
