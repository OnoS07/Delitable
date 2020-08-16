require 'rails_helper'

RSpec.describe Genre, type: :model do
	before(:each) do
	  	@genre = build(:genre)
 	end

 	it "ジャンルの作成ができる" do
 		expect(@genre).to be_valid
 	end
 	it "ジャンル名がない場合、無効にする" do
 		@genre.name = nil
 		@genre.valid?
 		expect(@genre.errors[:name]).to include("can't be blank")
 	end
 	it "ジャンル名が重複する場合、無効にする" do
	  	@genre = create(:genre)
	  	@genre_2 = build(:genre)
	  	@genre_2.valid?
	  	expect(@genre_2.errors[:name]).to include("has already been taken")
 	end

 	it "ジャンル説明がない場合、無効にする" do
 		@genre.introduction = nil
 		@genre.valid?
 		expect(@genre.errors[:introduction]).to include("can't be blank")
 	end
 	it "ジャンル説明が200文字以上の場合、無効にする" do
 		@genre.introduction = "a" * 201
 		@genre.valid?
 		expect(@genre.errors[:introduction]).to include("is too long (maximum is 200 characters)")
 	end
end
