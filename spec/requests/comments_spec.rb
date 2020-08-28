require 'rails_helper'

RSpec.describe "Comments", type: :request do
	before do
		@customer = create(:customer)
		@recipe = create(:recipe, customer_id: @customer.id)
		sign_in @customer
	end
	it "コメントが作成できる" do
		post recipe_comments_path(@recipe), params: { comment: FactoryBot.attributes_for(:comment) }, xhr: true
		expect(response).to have_http_status(200)
	end
	it "コメントが1件追加されている" do
		expect do
			post recipe_comments_path(@recipe), params: { comment: FactoryBot.attributes_for(:comment) }, xhr: true
		end.to change(Comment, :count).by(1)
	end

	it "値が正しくない場合、コメントの作成に失敗する" do
		expect do
			post recipe_comments_path(@recipe), params: { comment: FactoryBot.attributes_for(:comment, content: nil ) }, xhr: true
		end.to_not change(Comment, :count)
	end

	context "コメントが必要なリクエスト" do
		before do
			@comment = create(:comment, recipe_id: @recipe.id, customer_id: @customer.id)
		end
		it "コメントの削除ができる" do
			delete recipe_comment_path(@comment, @recipe), xhr: true
			expect(response).to have_http_status(200)
		end
		it "コメントが1件減っている" do
			expect do
				delete recipe_comment_path(@comment, @recipe), xhr: true
			end.to change(Comment, :count).by(-1)
		end
	end
end
