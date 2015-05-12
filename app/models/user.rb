class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

         def admin?
         	role == 'admin'
         end

         def moderator?
         	role == 'moderator'
         end

         def member?
         	role == 'member'
         end

         def guest?
         	role == 'guest'
         end
end
