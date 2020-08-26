require 'rails_helper'

RSpec.describe Order, type: :model do
	before(:each) do
		@customer = create(:customer)
	  	@order = build(:order, customer_id: @customer.id)
 	end

 	it "注文の作成ができる" do
 		expect(@order).to be_valid
 	end
 	it "宛名がない場合、無効にする" do
 		@order.name = nil
 		@order.valid?
 		expect(@order.errors[:name]).to include("を入力してください")
 	end

 	it "配送先がない場合、無効にする" do
 		@order.address = nil
 		@order.valid?
 		expect(@order.errors[:address]).to include("を入力してください")
 	end

 	it "郵便番号がない場合、無効にする" do
 		@order.postcode = nil
 		@order.valid?
 		expect(@order.errors[:postcode]).to include("を入力してください")
 	end

 	it "郵便番号が７桁でない場合、無効にする" do
 		@order.postcode.size != 7
 		@order.valid?
 		expect(@order.postcode.size).to eq 7
 	end
end
