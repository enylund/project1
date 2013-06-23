class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    user_follows = FollowChannel.find_all_by_user_id(params[:id])
    the_channels = Array.new
    user_follows.each do |row|
      the_channels << row[:channel_id]
    end
    @array_of_channels_a_user_follows = Channel.find(the_channels)
  end
end
