class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :read, :home
    if current_user
      # Fetch the 5 most recent approved posts
      @posts = Post.where(status: 'approved')
                   .includes(:comments)
                   .order(created_at: :desc)
                   .limit(5)
    else
      @posts = [] # or you could redirect the user, or show a message
    end
  end
end
