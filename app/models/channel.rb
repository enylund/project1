class Channel < ActiveRecord::Base
  belongs_to :user
  has_many :posts, :dependent => :destroy
  has_attached_file :postimage, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :collaborations
  has_many :users, :through => :collaborations

  def visible_to?(user)
    chan_privacy = self.privacy
    if chan_privacy == 'private' && (user != self.user)
      false
    else 
      true
    end
  end
end
