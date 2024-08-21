# app/admin/users.rb
ActiveAdmin.register User do
  permit_params :email, :username, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :usertype, :failed_attempts, :unlock_token, :locked_at, :current_sign_in_at, :last_sign_in_at

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :usertype
    column :failed_attempts
    column :locked_at
    column :current_sign_in_at
    column :last_sign_in_at
    column :created_at
    actions
  end

  filter :email
  filter :username
  filter :failed_attempts
  filter :locked_at
  filter :current_sign_in_at
  filter :last_sign_in_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :failed_attempts
      f.input :locked_at, as: :datetime_picker
      f.input :current_sign_in_at, as: :datetime_picker
      f.input :last_sign_in_at, as: :datetime_picker
    end
    f.actions
  end
end
