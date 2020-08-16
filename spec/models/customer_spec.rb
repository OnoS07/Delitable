require 'rails_helper'

RSpec.describe Customer, type: :model do
	before(:each) do
	  	@customer = build(:customer)
 	end
  it "ユーザー登録ができる" do
	expect(@customer).to be_valid
  end

  it "名前がない場合、無効にする" do
  	@customer.account_name = nil
  	@customer.valid?
  	expect(@customer.errors[:account_name]).to include("can't be blank")
  end

  it "名前が15文字以上の場合、無効にする" do
   	#length: { maximum: 15 }
	@customer.account_name = "a" * 16
  	@customer.valid?
  	expect(@customer.errors[:account_name]).to include("is too long (maximum is 15 characters)")
  end

  it "メールアドレスがない場合、無効にする" do
  	@customer.email = nil
  	@customer.valid?
  	expect(@customer.errors[:email]).to include("can't be blank")
  end

  it "メールアドレスが重複する場合、無効にする" do
  	#uniqueness: true
  	@customer = create(:customer)
  	@customer_2 = build(:customer)
  	@customer_2.valid?
  	expect(@customer_2.errors[:email]).to include("has already been taken")
  end
end
