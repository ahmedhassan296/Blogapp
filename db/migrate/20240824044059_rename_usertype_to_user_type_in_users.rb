# frozen_string_literal: true

class RenameUsertypeToUserTypeInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :usertype, :user_type
  end
end
