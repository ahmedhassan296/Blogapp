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
      if resource.admin?
        AdminUser.create(email: resource.email, password: resource.password)
        sign_up(resource_name, resource)
        redirect_to admin_dashboard_path
      elsif resource.moderator?
        sign_up(resource_name, resource)
        redirect_to moderators_moderator_dashboard_path
      else
        sign_up(resource_name, resource)
        redirect_to root_path
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?

    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ? :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end

      if resource.admin?
        redirect_to admin_dashboard_path
      elsif resource.moderator?
        redirect_to moderators_moderator_dashboard_path
      else
        redirect_to posts_path
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

  # Custom method to update the resource with or without the current password
  def update_resource(resource, params)
  if params[:password].present?
    if resource.valid_password?(params[:current_password])
      # Remove `current_password` from params before updating the resource
      resource.update(params.except(:current_password))
    else
      resource.errors.add(:current_password, :invalid)
      false
    end
  else
    params.delete(:password)
    params.delete(:password_confirmation)
    resource.update_without_password(params.except(:current_password))
  end
end
end
