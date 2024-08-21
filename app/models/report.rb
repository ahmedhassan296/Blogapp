class Report < ApplicationRecord
  belongs_to :user
  belongs_to :reportable, polymorphic: true

  validates :reason, presence: true

   def self.ransackable_attributes(auth_object = nil)
    ["user_id", "reportable_type", "reportable_id", "reason", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user reportable] # Replace with your actual association names
  end
end
