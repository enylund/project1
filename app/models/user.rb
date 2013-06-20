class User < ActiveRecord::Base
  has_many :channels
  has_many :posts
  has_many :comments
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :login
  # attr_accessible :email, :password, :password_confirmation
end
