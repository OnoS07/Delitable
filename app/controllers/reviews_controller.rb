class ReviewsController < ApplicationController
	def create
		@review = Review.new(review_params)
		@review.customer_id = current_customer.id
		@review.product_id = params[:product_id]
		@product = Product.find(params[:product_id])
		@review.save
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
