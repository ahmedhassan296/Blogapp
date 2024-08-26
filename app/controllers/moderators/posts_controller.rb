# app/controllers/moderators/posts_controller.rb
module Moderators
  class PostsController < ApplicationController

    before_action :authenticate_user!
    before_action :authorize_moderator!
  
    before_action :set_post, only: [:approve, :delete_reported , :pending]

    # GET /moderators/posts
    def index
      @user = current_user

      @posts = Post.all # or use a scope like `Post.pending_review` if you have one
    end

    def pending
      if @post.update(status: 'pending')
        redirect_to mod_posts_index_moderators_posts_path, notice: 'Post pended successfully.'
      else
        redirect_to mod_posts_index_moderators_posts_path, alert: 'Failed to approve the post.'
      end
    end
    # PATCH /moderators/posts/:id/approve
    def approve
      if @post.update(status: 'approved')
        redirect_to mod_posts_index_moderators_posts_path, notice: 'Post approved successfully.'
      else
        redirect_to mod_posts_index_moderators_posts_path, alert: 'Failed to approve the post.'
      end
    end

    # DELETE /moderators/posts/:id/delete_reported
    def delete_reported
      if @post.destroy
        redirect_to moderators_posts_path, notice: 'Post deleted successfully.'
      else
        redirect_to moderators_posts_path, alert: 'Failed to delete the post.'
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end
  
    def authorize_moderator!
      redirect_to root_path unless current_user.moderator?
    end
  end
end
