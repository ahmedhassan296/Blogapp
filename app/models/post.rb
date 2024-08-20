class Post < ApplicationRecord
	after_initialize :set_default_status, if: :new_record?

	has_one_attached :image
	belongs_to :user
	has_many :comments
	 has_many :likes, as: :likeable, dependent: :destroy

	private

  def set_default_status
    self.status ||= 'pending'
  end
end
