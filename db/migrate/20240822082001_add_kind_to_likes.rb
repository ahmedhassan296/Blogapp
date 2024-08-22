class AddKindToLikes < ActiveRecord::Migration[7.1]
  def change
    add_column :likes, :kind, :string, default: 'thumb_up'
    add_index :likes, :kind
  end
end
