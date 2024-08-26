class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true
   validates :kind, inclusion: { in: %w[thumb_up thumb_down] }

validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }
   

def self.ransackable_attributes(auth_object = nil)
    ["user_id", "likeable_type", "likeable_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user likeable] # Replace with your actual association names
  end
end
