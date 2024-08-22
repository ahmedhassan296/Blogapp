class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true
  # existing associations
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

 has_many_attached :images

def self.ransackable_attributes(auth_object = nil)
  ["content", "post_id", "user_id", "created_at", "updated_at"]
end


end
