# app/controllers/moderators/posts_controller.rb
module Moderators
  class PostsController < ApplicationController
    before_action :set_post, only: [:approve, :delete_reported]

    # GET /moderators/posts
    def index
      @posts = Post.all # or use a scope like `Post.pending_review` if you have one
    end

    # PATCH /moderators/posts/:id/approve
    def approve
      if @post.update(status: 'approved')
        redirect_to moderators_posts_path, notice: 'Post approved successfully.'
      else
        redirect_to moderators_posts_path, alert: 'Failed to approve the post.'
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
  end
end
