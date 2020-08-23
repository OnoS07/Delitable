require 'rails_helper'

RSpec.describe Product, type: :model do
	before(:each) do
	  	@product = build(:product)
 	end

 	it "商品の作成ができる" do
 		expect(@product).to be_valid
 	end
 	it "商品名がない場合、無効にする" do
 		@product.name = nil
 		@product.valid?
 		expect(@product.errors[:name]).to include("を入力してください")
 	end
 	it "商品の紹介文がない場合、無効にする" do
 		@product.introduction = nil
 		@product.valid?
 		expect(@product.errors[:introduction]).to include("を入力してください")
 	end

 	it "価格がない場合、無効にする" do
 		@product.price = nil
 		@product.valid?
 		expect(@product.errors[:price]).to include("を入力してください")
 	end
 	it "価格が0円の場合、無効にする" do
 		@product.price = 0
 		@product.valid?
 		expect(@product.errors[:price]).to include("は0より大きい値にしてください")
 	end
end
