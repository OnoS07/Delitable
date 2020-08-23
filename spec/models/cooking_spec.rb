require 'rails_helper'

RSpec.describe Cooking, type: :model do
	before(:each) do
	  	@cooking = build(:cooking)
 	end

 	it "作り方の作成ができる" do
 		expect(@cooking).to be_valid
 	end
 	it "作り方本文がない場合、無効にする" do
 		@cooking.content = nil
 		@cooking.valid?
 		expect(@cooking.errors[:content]).to include("を入力してください")
 	end
 	it "作り方本文が200文字以上の場合、無効にする" do
 		@cooking.content = "a" * 201
 		@cooking.valid?
 		expect(@cooking.errors[:content]).to include("は200文字以内で入力してください")
 	end
end
