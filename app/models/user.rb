class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

before_destroy :destroy_associations

  private

  def destroy_associations
    posts.destroy_all
    comments.destroy_all
    likes.destroy_all
    
  end

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
has_many :reports, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :trackable, :confirmable

  validates :username, presence: true, uniqueness: true

  enum usertype: { user: 0, admin: 1, moderator: 2 }

  def is_admin?
    usertype == 'admin'
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "current_sign_in_at", "email", "failed_attempts", "id", "last_sign_in_at", "locked_at", "remember_created_at", "reset_password_sent_at", "reset_password_token", "unlock_token", "updated_at", "username"]
  end


end
