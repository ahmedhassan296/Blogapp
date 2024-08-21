ActiveAdmin.register Post do
  permit_params :title, :description, :status, :user_id, :content

  # Index page configuration
  index do
    selectable_column
    id_column
    column :title
    column :description
    column :status
    column :user_id
    column :created_at
    column :updated_at
    actions
  end

  # Filter configuration
  filter :title
  filter :description
  filter :status
  filter :user_id
  filter :created_at
  filter :updated_at

  # Form configuration
  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :status, as: :select, collection: Post.statuses.keys
      f.input :user_id, as: :select, collection: User.pluck(:username, :id), include_blank: false
    end
    f.actions
  end

  
end
