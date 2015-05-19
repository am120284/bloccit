class FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)
    authorize favorite

    if favorite.save
      flash[:notice] = "Post Favored."
      redirect_to [post.topic,post]
    else
      flash[:error] = "There was an error adding Post to favorites. Please try again."
    end

  end

  def destroy
    post     =   Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)
    favorite.destroy
    authorize favorite

    if favorite.destroy
      flash[:notice] = "Post successfully unfavored."
      redirect_to [post.topic,post]
    else
      flash[:notice] = "There was an error un-favoriting the post, please try again."
      redirect_to [post.topic,post]
    end
  end
end
