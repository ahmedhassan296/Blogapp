# frozen_string_literal: true

class CreateSuggestions < ActiveRecord::Migration[7.1]
  def change
    create_table :suggestions do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :suggestions }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
