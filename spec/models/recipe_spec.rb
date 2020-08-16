require 'rails_helper'

RSpec.describe Recipe, type: :model do
	before(:each) do
	  	@recipe = build(:recipe)
 	end
  it "レシピの作成ができる" do
	expect(@recipe).to be_valid
  end

  it "タイトルがない場合、無効にする" do
  	@recipe.title = nil
  	@recipe.valid?
  	expect(@recipe.errors[:title]).to include("can't be blank")
  end
  it "タイトルが30文字以上の場合、無効にする" do
  	@recipe.title = "a" * 31
  	@recipe.valid?
  	expect(@recipe.errors[:title]).to include("is too long (maximum is 30 characters)")
  end

  it "紹介文がない場合、無効にする" do
  	@recipe.introduction = nil
  	@recipe.valid?
  	expect(@recipe.errors[:introduction]).to include("can't be blank")
  end
  it "紹介文が200文字以上の場合、無効にする" do
  	@recipe.introduction = "a" * 201
  	@recipe.valid?
  	expect(@recipe.errors[:introduction]).to include("is too long (maximum is 200 characters)")
  end

  it "分量がない場合、無効にする" do
  	@recipe.amount = nil
  	@recipe.valid?
  	expect(@recipe.errors[:amount]).to include("can't be blank")
  end
  it "分量が10文字以上の場合、無効にする" do
  	@recipe.amount = "a" * 11
  	@recipe.valid?
  	expect(@recipe.errors[:amount]).to include("is too long (maximum is 10 characters)")
  end
end
