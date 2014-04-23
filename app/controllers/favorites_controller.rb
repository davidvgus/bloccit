class FavoritesController < ApplicationController


  def create
    setup(current_user.favorites.build(post: @post))

    make_flash(:create, @favorite.save)
    redirect_to_post
  end

  def destroy
    setup(current_user.favorites.find(params[:id]))

    make_flash(:destroy, @favorite.destroy)
    redirect_to_post
  end

  private

  def make_flash(action, success)
    create_hash = {notice: "Favorited post", error: "Unable to add favorite.  Please try again."}
    destroy_hash = {notice: "Removed Favorite", error: "Unable to remove favorite.  Please try again."}
    if success
      flash[:notice] = action == :create ? create_hash[:notice] : destroy_hash[:notice]
    else
      flash[:error] = action == :create ? create_hash[:error] : destroy_hash[:error]
    end
  end

  def redirect_to_post
      redirect_to [@topic, @post]
  end

  def setup(favorite)
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    if favorite.new_record?
      @favorite = current_user.favorites.build(post: @post)
    else
      @favorite = current_user.favorites.find(params[:id])
    end
    authorize @favorite
  end
end
