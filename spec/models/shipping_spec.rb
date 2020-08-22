require 'rails_helper'

RSpec.describe Shipping, type: :model do
	before(:each) do
	  	@shipping = build(:shipping)
 	end

 	it "配送先の作成ができる" do
 		expect(@shipping).to be_valid
 	end
 	it "宛名がない場合、無効にする" do
 		@shipping.name = nil
 		@shipping.valid?
 		expect(@shipping.errors[:name]).to include("can't be blank")
 	end

 	it "配送先がない場合、無効にする" do
 		@shipping.address = nil
 		@shipping.valid?
 		expect(@shipping.errors[:address]).to include("can't be blank")
 	end

 	it "郵便番号がない場合、無効にする" do
 		@shipping.postcode = nil
 		@shipping.valid?
 		expect(@shipping.errors[:postcode]).to include("can't be blank")
 	end

 	it "郵便番号が７桁でない場合、無効にする" do
 		@shipping.postcode.size != 7
 		@shipping.valid?
 		expect(@shipping.postcode.size).to eq 7
 	end
end
