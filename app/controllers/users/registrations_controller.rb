# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
       
    if resource.persisted?
      debugger
      if resource.admin?
        # Create AdminUser or handle special cases for Admin users
        AdminUser.create(email: resource.email, password: resource.password)
        sign_up(resource_name, resource)
        redirect_to admin_dashboard_path
        return
      elsif resource.moderator?
        # Redirect to Moderator dashboard
        sign_up(resource_name, resource)
        redirect_to moderators_moderator_dashboard_path
        return
      else
        # Redirect to User dashboard
        sign_up(resource_name, resource)
        redirect_to posts_path
        return
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  # Permit additional parameters for sign up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :usertype])
  end

  # Permit additional parameters for account update
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
