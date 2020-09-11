class ReviewsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    review = Review.new(review_params)
    review.customer_id = current_customer.id
    review.product_id = params[:product_id]
    documentSentiment = Language.get_data(review_params[:content])
    review.score = documentSentiment['score']
    if review.save
      flash[:review_create] = 'NEW REVIEW CREATE !'
      redirect_to product_path(product)
    else
      redirect_to product_path(product),:flash=>{error_messages: review.errors.full_messages}
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @product = Product.find(params[:product_id])
    @review.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:product_id, :customer_id, :content, :rate)
  end
end
