class CommentsController < ApplicationController
  before_action :authenticate_customer!
  def create
    @comment = Comment.new(comment_params)
    @comment.customer_id = current_customer.id
    @comment.recipe_id = params[:recipe_id]
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments.all
    flash.now[:comment] = 'NEW COMMENT CREATE !' if @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments.all
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
