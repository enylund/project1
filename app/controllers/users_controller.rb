class UsersController < ApplicationController
  def show
    @user = User.find(current_user)
    user_follows = FollowChannel.find_all_by_user_id(current_user)
    the_channels = Array.new
    user_follows.each do |row|
      the_channels << row[:channel_id]
    end
    @array_of_channels_a_user_follows = Channel.find(the_channels)
    # raise @what_you_want.to_yaml
  end
end
