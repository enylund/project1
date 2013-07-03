class Channel < ActiveRecord::Base
  belongs_to :user
  has_many :posts, :dependent => :destroy
  has_attached_file :postimage, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :collaborations, dependent: :destroy
  has_many :users, :through => :collaborations
  attr_reader :user_tokens

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end

  def visible_to?(user)
    chan_privacy = self.privacy
    # if chan_privacy == 'private' && (user != self.user)
    #   false
    # else 
    #   true
    # end
    if chan_privacy != 'private' || user == self.user
      true
    # elsif user == self.user # can't access collab model? || user.id    # && chan_privacy == private
    else
      false
    end

  end


end
