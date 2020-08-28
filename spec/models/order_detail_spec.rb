require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
	before(:each) do
		@customer = create(:customer)
		@genre = create(:genre)
		@product = create(:product, genre_id: @genre.id)
		@order = create(:order, customer_id: @customer.id)
	  	@order_detail = build(:order_detail, order_id: @order.id, product_id: @product.id)
 	end

 	it "注文詳細の作成ができる" do
 		expect(@order_detail).to be_valid
 	end
 	it "価格がない場合、無効にする" do
 		@order_detail.price = nil
 		@order_detail.valid?
 		expect(@order_detail.errors[:price]).to include("を入力してください")
 	end
 	it "価格が0円の場合、無効にする" do
 		@order_detail.price = 0
 		@order_detail.valid?
 		expect(@order_detail.errors[:price]).to include("は0より大きい値にしてください")
 	end

 	it "個数がない場合、無効にする" do
 		@order_detail.count = nil
 		@order_detail.valid?
 		expect(@order_detail.errors[:count]).to include("を入力してください")
 	end
 	it "個数が0個の場合、無効にする" do
 		@order_detail.count = 0
 		@order_detail.valid?
 		expect(@order_detail.errors[:count]).to include("は0より大きい値にしてください")
 	end
end
