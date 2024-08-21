ActiveAdmin.register Report do
  # Permit parameters for creating and updating reports
  permit_params :user_id, :reportable_type, :reportable_id, :reason

  # Index page configuration
  index do
    selectable_column
    id_column
    column :user_id
    column :reportable_type
    column :reportable_id
    column :reason
    column :created_at
    column :updated_at
    actions
  end

  # Filters to search reports based on specific attributes
  filter :user_id
  filter :reportable_type
  filter :reportable_id
  filter :reason
  filter :created_at
  filter :updated_at

  # Form for creating and editing reports
  form do |f|
    f.inputs do
      f.input :user_id, as: :select, collection: User.all.collect { |u| [u.username, u.id] }
      f.input :reportable_type, as: :select, collection: ['Post', 'Comment'] # Assuming these are the possible types
      f.input :reportable_id, as: :number
      f.input :reason
    end
    f.actions
  end
end
