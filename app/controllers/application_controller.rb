class ApplicationController < ActionController::Base


# 	def after_sign_in_path_for(resource)
  #   if resource.admin?
  #     admin_dashboard_path  # Replace with your admin path
  #   else
  #     user_dashboard_path   # Replace with your regular user path
  #   end
  # end
  rescue_from CanCan::AccessDenied do |exception|
    if current_user&.user_type == 'moderator'
      redirect_to mod_posts_index_moderators_posts_path, alert: exception.message
    else
      redirect_to root_url, alert: exception.message
    end
  end

  helper LikesHelper
  
end
