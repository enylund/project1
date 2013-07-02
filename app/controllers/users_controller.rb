class UsersController < ApplicationController

  def index
    @users = User.order(:username).where("username like ?", "%#{params[:term]}%")
    render json: @users.map(&:username)
  end

  def show
    @user = User.find_by_username(params[:username])
    # @user = User.where(username: params[:username]).take
    @title = @user.username + "'s biblio"
    private_channel_show_check()
    create_array_of_followed_channels_to_show()

  end

  def private_channel_show_check
    if current_user != @user
      @channels_to_show = @user.channels.where('privacy != ?', 'private')
      # raise @channels_to_show.to_yaml
    else
      @channels_to_show = @user.channels
    end
  end

  def create_array_of_followed_channels_to_show
    user_follows = FollowChannel.where(user_id: @user.id)
    the_channels = Array.new
    user_follows.each do |row|
      the_channels << row[:channel_id]
    end
    @array_of_channels_a_user_follows = Channel.find(the_channels)
  end

  def search
    redirect_to user_path(params[:q])
  end

end
