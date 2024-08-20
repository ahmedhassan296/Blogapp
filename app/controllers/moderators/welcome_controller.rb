class Moderators::WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_moderator!

  def index
    # You can set up any instance variables here if needed
    @user = current_user
    
  end

  private

  def authorize_moderator!
    redirect_to root_path unless current_user.moderator?
  end
end
