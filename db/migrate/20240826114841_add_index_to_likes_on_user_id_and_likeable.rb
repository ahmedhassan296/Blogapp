# frozen_string_literal: true

class AddIndexToLikesOnUserIdAndLikeable < ActiveRecord::Migration[7.1]
  def change
    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true, name: 'index_likes_on_user_and_likeable'
  end
end
