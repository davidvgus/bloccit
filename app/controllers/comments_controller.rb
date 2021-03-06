class CommentsController < ApplicationController

  respond_to :html, :js

  def create
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find( params[:post_id] )
    @comments = @post.comments

    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[:notice] =  "Comment was saved successfully."
    else
      flash[:error] = "Error creating comment. Please try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was deleted"
    else
      flash[:error] = "Error deleting comment"
    end

    respond_with(@comment) do |f|
      f.html {redirect_to [@topic, @post]}
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
