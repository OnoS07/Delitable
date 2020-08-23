require 'rails_helper'

RSpec.describe Comment, type: :model do
	before(:each) do
	  	@comment = build(:comment)
 	end
 	it "コメントの作成ができる" do
 		expect(@comment).to be_valid
 	end

 	it "コメント本文がない場合、無効にする" do
	  	@comment.content = nil
	  	@comment.valid?
	  	expect(@comment.errors[:content]).to include("を入力してください")
 	end

 	it "コメント本文が200文字以上の場合、無効にする" do
	  	@comment.content = "a" * 201
	  	@comment.valid?
	  	expect(@comment.errors[:content]).to include("は200文字以内で入力してください")
 	end
end
