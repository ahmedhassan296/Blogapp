ActiveAdmin.register Like do
  # Permit parameters for creating and updating likes
  permit_params :user_id, :likeable_type, :likeable_id

  # Index page configuration
  index do
    selectable_column
    id_column
    column :user_id
    column :likeable_type
    column :likeable_id
    column :created_at
    column :updated_at
    actions
  end

  # Filters to search likes based on specific attributes
  filter :user_id, as: :select, collection: -> { User.all.collect { |u| [u.username, u.id] } }
  filter :likeable_type, as: :select, collection: -> { Like.pluck(:likeable_type).uniq }
  filter :likeable_id
  filter :created_at
  filter :updated_at

  # Form for creating and editing likes
  form do |f|
    f.inputs do
      f.input :user_id, as: :select, collection: User.all.collect { |u| [u.username, u.id] }, include_blank: false
      f.input :likeable_type, as: :select, collection: Like.pluck(:likeable_type).uniq
      f.input :likeable_id
    end
    f.actions
  end
end
