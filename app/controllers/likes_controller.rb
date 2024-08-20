class LikesController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(user: current_user)

    respond_to do |format|
     # format.html { redirect_to @post, notice: 'Liked!' }
      format.js # This will look for create.js.erb for AJAX requests
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    respond_to do |format|
     # format.html { redirect_to @like.likeable, notice: 'Unliked!' }
      format.js # This will look for destroy.js.erb for AJAX requests
    end
  end
end
