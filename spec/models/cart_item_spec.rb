require 'rails_helper'

RSpec.describe CartItem, type: :model do
	before(:each) do
		@customer = create(:customer)
		@product = create(:product)
	  	@cart_item = build(:cart_item, customer_id: @customer.id, product_id: @product.id)
 	end

 	it "カート内商品を作成できる" do
 		 expect(@cart_item).to be_valid
 	end

 	it "個数が選択されていない場合、無効にする" do
 		@cart_item.count = nil
 		@cart_item.valid?
 		expect(@cart_item.errors[:count]).to include("を入力してください")
 	end
 	it "個数が0個の場合、無効にする" do
 		@cart_item.count = 0
 		@cart_item.valid?
 		expect(@cart_item.errors[:count]).to include("は1以上の値にしてください")
 	end
 	it "個数が10個以上の場合、無効にする" do
 		@cart_item.count = 11
 		@cart_item.valid?
 		expect(@cart_item.errors[:count]).to include("は10以下の値にしてください")
 	end
end
