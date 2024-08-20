module Moderators
  class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_moderator

    # Action to approve a post

    
  
   

    def approve
      # @post = Post.find(params[:id])
      # if @post.update(approved: true)
      #   redirect_to moderators_posts_path, notice: 'Post approved successfully.'
      # else
      #   redirect_to moderators_posts_path, alert: 'Failed to approve post.'
      # end
         @posts = Post.where(status: 'pending').order(created_at: :desc)
    end

    # Action to delete a reported post
    def delete_reported
      @post = Post.find(params[:id])	
      if @post.destroy
        redirect_to moderators_posts_path, notice: 'Post deleted successfully.'
      else
        redirect_to moderators_posts_path, alert: 'Failed to delete post.'
      end
    end

    private

    # Ensure the user is a moderator
    def authorize_moderator
      unless current_user.moderator?
        redirect_to root_path, alert: 'You are not authorized to access this section.'
      end
    end
  end
end
