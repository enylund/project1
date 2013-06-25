require 'open-uri'
class User < ActiveRecord::Base
  has_many :channels
  has_many :posts
  has_many :comments
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  # attr_accessible :login
  # attr_accessible :email, :password, :password_confirmation
  attr_accessor :login

  validates :username, :uniqueness => { :case_sensitive => false }

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/a598609adcd811e2a1e322000a9e0853_7.jpg"

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def avatar_from_url(url)
  self.avatar = URI.parse(url)
  end
end

