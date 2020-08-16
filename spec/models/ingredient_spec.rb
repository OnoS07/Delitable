require 'rails_helper'

RSpec.describe Ingredient, type: :model do
	before(:each) do
	  	@ingredient = build(:ingredient)
 	end

 	it "材料の作成ができる" do
 		expect(@ingredient).to be_valid
 	end
 	it "材料本文がない場合、無効にする" do
 		@ingredient.content = nil
 		@ingredient.valid?
 		expect(@ingredient.errors[:content]).to include("can't be blank")
 	end
 	it "作り方本文が20文字以上の場合、無効にする" do
 		@ingredient.content = "a" * 21
 		@ingredient.valid?
 		expect(@ingredient.errors[:content]).to include("is too long (maximum is 20 characters)")
 	end

 	it "分量がない場合、無効にする" do
 		@ingredient.amount = nil
 		@ingredient.valid?
 		expect(@ingredient.errors[:amount]).to include("can't be blank")
 	end
 	it "分量が10文字以上の場合、無効にする" do
 		@ingredient.amount = "a" * 11
 		@ingredient.valid?
 		expect(@ingredient.errors[:amount]).to include("is too long (maximum is 10 characters)")
 	end
end
