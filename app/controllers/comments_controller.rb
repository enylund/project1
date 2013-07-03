class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:comment][:post_id])
    if @post.visible_to?(current_user) || Collaboration.where(channel: @post.channel, user: current_user).present?
      @comment = Comment.new(comment_params)
      @comment.user = current_user
      @comment.save
      redirect_to @post
    else
      redirect_to :root, notice: "You can't do that!"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if current_user != comment.user
      render text: "woah chill"
    else
      post = comment.post
      comment.destroy
      redirect_to post
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end