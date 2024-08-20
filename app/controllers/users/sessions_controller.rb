# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
 def create
    super do |resource|
     
      if resource.moderator?
        # Redirect Moderator to the Moderator dashboard
        redirect_to moderators_moderator_dashboard_path and return
      else
        # Redirect regular User to the Posts page
        redirect_to posts_path and return
      end
    end
  end
  # DELETE /resource/sign_out
 # def destroy
 #    super do
 #      # Clear the session data
 #      reset_session

 #      # Set a flash message
 #      flash[:notice] = "You have successfully logged out."

 #      # Redirect to posts index
 #      redirect_to posts_path
 #    end
 #  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
