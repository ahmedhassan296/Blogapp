class HomeController < ApplicationController
  def index
    if current_user
      # Get the start and end of the current day
      start_of_day = Time.zone.now.beginning_of_day
      end_of_day = Time.zone.now.end_of_day

      # Fetch approved posts created today
      @posts = Post.where(status: 'approved')
                   .where(created_at: start_of_day..end_of_day)
                   .includes(:comments)
                   .order(created_at: :desc)
    else
      @posts = [] # or you could redirect the user, or show a message
    end
  end
end
