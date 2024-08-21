class Post < ApplicationRecord
  after_initialize :set_default_status, if: :new_record?

  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
   has_many :reports, as: :reportable, dependent: :destroy

  # Enum definition for status
  enum status: { pending: 'pending', approved: 'approved', reported: 'reported' }

  private

  def set_default_status
    self.status ||= 'pending'
  end
def self.ransackable_attributes(auth_object = nil)
  ["title", "description", "created_at", "updated_at", "user_id", "status"]
end

end
