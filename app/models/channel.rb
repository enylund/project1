class Channel < ActiveRecord::Base
  belongs_to :user
  has_many :posts

  def the_name
  	name + " "
  end

end
