class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  has_many :comments, :dependent => :destroy

has_attached_file :postimage, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
