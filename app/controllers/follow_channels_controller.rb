class FollowChannelsController < ApplicationController

  def create
    FollowChannel.create(follow_params)
    @channel = Channel.find(params[:follow_channel][:channel_id])
    # raise @channel.name.to_yaml
    # redirect_to :back
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @channel = Channel.find(params[:follow_channel][:channel_id])

    @current_user_id_to_destroy_follow = params[:follow_channel][:user_id].to_i
    @current_channel_id_to_destroy_follow = params[:follow_channel][:channel_id].to_i

    @follow_id_to_destroy = FollowChannel.destroy_all(:channel_id => @current_channel_id_to_destroy_follow, :user_id => @current_user_id_to_destroy_follow).first.id
    respond_to do |format|
      format.js
    end
  end

  private
  def follow_params
    params.require(:follow_channel).permit(:user_id, :channel_id)
  end
end
