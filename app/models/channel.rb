class Channel < ActiveRecord::Base
  belongs_to :user
  has_many :posts, :dependent => :destroy
  has_attached_file :postimage, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
