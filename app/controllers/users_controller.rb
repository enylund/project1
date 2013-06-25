class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    private_channel_show_check()
    create_array_of_followed_channels_to_show()

  end

  def private_channel_show_check
    if current_user != @user.id
      @channels_to_show = @user.channels.where('privacy != ?', 'private').all
      # raise @channels_to_show.to_yaml
    end
  end

  def create_array_of_followed_channels_to_show
    user_follows = FollowChannel.find_all_by_user_id(params[:id])
    the_channels = Array.new
    user_follows.each do |row|
      the_channels << row[:channel_id]
    end
    @array_of_channels_a_user_follows = Channel.find(the_channels)
  end


end
