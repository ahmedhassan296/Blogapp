class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   has_many :comments
  has_many :posts
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable

validates :username, presence: true

          enum usertype: { user: 0, admin: 1, moderator: 2 }
end
