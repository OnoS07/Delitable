class CommentsController < ApplicationController
  before_action :authenticate_customer!
  def create
  	@comment = Comment.new(comment_params)
  	@comment.customer_id = current_customer.id
    @comment.recipe_id = params[:recipe_id]
  	@comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  	redirect_back(fallback_location: root_path)
  end

  private
  def comment_params
  	params.require(:comment).permit(:content)
  end
end
