class FollowChannelsController < ApplicationController

  def create
    FollowChannel.create(follow_params)
    redirect_to :back
  end

  def destroy
    @current_user_id_to_destroy_follow = params[:follow_channel][:user_id].to_i
    @current_channel_id_to_destroy_follow = params[:follow_channel][:channel_id].to_i

    @follow_id_to_destroy = FollowChannel.destroy_all(:channel_id => @current_channel_id_to_destroy_follow, :user_id => @current_user_id_to_destroy_follow).first.id
    redirect_to :back
  end

  private
  def follow_params
    params.require(:follow_channel).permit(:user_id, :channel_id)
  end
end
