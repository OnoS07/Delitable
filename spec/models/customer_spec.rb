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
  	expect(@customer.errors[:account_name]).to include("を入力してください")
  end
  it "名前が15文字以上の場合、無効にする" do
	@customer.account_name = "a" * 16
  	@customer.valid?
  	expect(@customer.errors[:account_name]).to include("は15文字以内で入力してください")
  end

  it "メールアドレスがない場合、無効にする" do
  	@customer.email = nil
  	@customer.valid?
  	expect(@customer.errors[:email]).to include("を入力してください")
  end
  it "メールアドレスが重複する場合、無効にする" do
  	@customer = create(:customer)
  	@customer_2 = build(:customer)
  	@customer_2.valid?
  	expect(@customer_2.errors[:email]).to include("はすでに存在します")
  end

  context "フォローメソッド" do
    before do
      @customer = create(:customer)
      @followed = Customer.create(account_name: "followed", email: "follow@test", password: "followtest")
    end
      it "フォローすることができる" do
        expect(@customer.follow(@followed.id)).to be_truthy
      end

      it "フォローを外すことができる" do
        @customer.follow(@followed.id)
        expect(@customer.unfollow(@followed.id)).to be_truthy
      end

      it "既にフォローしている" do
        @customer.follow(@followed.id)
        expect(@customer.following?(@followed)).to be_truthy
      end

      it "まだフォローしていない" do
        expect(@customer.following?(@followed)).to be_falsey
      end
  end

  context "レビューメソッド" do
    before do
      @customer = create(:customer)
      @product = create(:product)
    end
    it "既にレビューをしているか" do
      @review = create(:review)
      expect(@customer.reviewing?(@product)).to be_truthy
    end
    it "まだレビューをしていない" do
      expect(@customer.reviewing?(@product)).to be_falsey
    end
  end

end
