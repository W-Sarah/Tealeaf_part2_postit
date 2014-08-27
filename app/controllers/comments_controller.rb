class CommentsController < ApplicationController
  before_action :require_login



  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment successfully added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(user_id: current_user.id, voteable_type: "Comment", voteable_id: @comment.id, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Thanks for voting."
        else
          flash[:error] = "You can only vote on a post once"
        end
        redirect_to :back
      end
      format.js do
        format.js
      end
    end

  end



end
