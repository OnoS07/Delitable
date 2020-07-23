class CommentsController < ApplicationController
  before_action :authenticate_customer!
  def create
  	@comment = Comment.new(comment_params)
  	@comment.customer_id = current_customer.id
    @comment.recipe_id = params[:recipe_id]
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments.all
  	if @comment.save
      flash.now[:comment] = "NEW COMMENT CREATE !"
    else
      redirect_to recipe_path(@recipe, anchor: 'comments')
      flash[:not_comment] = "正しく入力ができていません。もう一度入力して下さい"
    end
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
