class Admins::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def delete
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  	redirect_back(fallback_location: root_path)
  end
end
