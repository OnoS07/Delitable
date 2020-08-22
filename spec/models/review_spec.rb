require 'rails_helper'

RSpec.describe Review, type: :model do
	before(:each) do
	  	@review = build(:review)
 	end

 	it "レビューの作成ができる" do
 		expect(@review).to be_valid
 	end

 	it "レビュー本文がない場合、無効にする" do
 		@review.content = nil
 		@review.valid?
 		expect(@review.errors[:content]).to include("can't be blank")
 	end

 	it "評価がない場合、無効にする" do
 		@review.rate = nil
 		@review.valid?
 		expect(@review.errors[:rate]).to include("can't be blank")
 	end
 	it "評価が5以上の場合、無効にする" do
 		@review.rate = 6
 		@review.valid?
 		expect(@review.errors[:rate]).to include("must be less than or equal to 5")
 	end
end
