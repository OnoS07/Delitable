require 'rails_helper'

RSpec.describe "Admins::Comments", type: :request do
	before do
		@admin = create(:admin)
		@customer = create(:customer)
		@recipe = create(:recipe, customer_id: @customer.id)
		@comment = create(:comment, recipe_id: @recipe.id, customer_id: @customer.id)
		sign_in @admin
	end
	it "コメントの削除リクエストが成功する" do
		delete admins_recipe_comment_path(@comment, @recipe)
		expect(response).to have_http_status(302)
	end
	it "コメントが1件減っている" do
		expect do
			delete admins_recipe_comment_path(@comment, @recipe)
		end.to change(Comment, :count).by(-1)
	end
end
