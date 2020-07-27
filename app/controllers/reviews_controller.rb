class ReviewsController < ApplicationController
	def create
		@review = Review.new(review_params)
		@review.customer_id = current_customer.id
		@review.product_id = params[:product_id]
		@product = Product.find(params[:product_id])
		if @review.save
			flash[:review_create] = "NEW REVIEW CREATE !"
		else
			flash[:review_error] = "評価が入力されていません"
		end
		redirect_to product_path(@product)
	end

	def destroy
		@review = Review.find(params[:id])
		@product = Product.find(params[:product_id])
		@review.destroy
		redirect_to product_path(@product)
	end

	private
	def review_params
		params.require(:review).permit(:product_id, :customer_id, :content, :rate)
	end
end
