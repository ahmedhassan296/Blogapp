class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  # existing associations
  has_many :reports, as: :reportable, dependent: :destroy

 has_many_attached :images
def self.ransackable_attributes(auth_object = nil)
  ["content", "post_id", "user_id", "created_at", "updated_at"]
end


end
