class Channel < ActiveRecord::Base
  has_many :posts
  belongs_to :user
end
