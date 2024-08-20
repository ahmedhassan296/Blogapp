class AddUsertypeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :usertype, :integer, null: false
  end
end
