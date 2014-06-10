class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = User.first #to change once we have login

    if @comment.save
      flash[:notice] = "Comment successfully added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end



end
