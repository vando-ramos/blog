class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.create!(comments_params)

    redirect_to comment.post, notice: 'Your comment was sent!'
  end

  private

  def comments_params
    params.require(:comment).permit(:post_id, :author, :body)
  end
end
