class CommentsController < ApplicationController
  def create
    #@topic    = Topic.find(params[:topic_id])
    @post     =  Post.find(params[:post_id])
    @comments = @post.comments

    #After separating the topics resources from the comments, Here in the Comments controller it cant find the topic
    #figure out how to find the topic through the comments

    @comment      = current_user.comments.build(comment_params)
    @comment.post = @post


    #authorize! :create, @comment, message: "You need be signed in to do that."
    if @comment.save
      flash[:notice] = "Comment was created."
      redirect_to post_comments_path(@post, @comments)
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render 'posts/show'
    end
  end

  def destroy
    @topic   =          Topic.find(params[:topic_id])
    @post    =   @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]

    else
      flash[:error]  = "Comment couldn't be deleted. Try again."
      redirect_to [@topic, @post]
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
