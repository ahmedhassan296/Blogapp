class Suggestion < ApplicationRecord
    belongs_to :user
    belongs_to :post
    belongs_to :parent, class_name: 'Suggestion', optional: true
    has_many :replies, class_name: 'Suggestion', foreign_key: 'parent_id', dependent: :destroy
  
    validates :content, presence: true
    enum status: { pending: 0, accepted: 1, rejected: 2 }

    before_validation :set_default_status, on: :create

    private
  
    # Callback method to set default status
    def set_default_status
      self.status ||= :pending
    end
  
    # Validations and other logic
end 
  