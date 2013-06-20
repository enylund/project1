class FollowChannelsController < ApplicationController

  def create
    FollowChannel.create(follow_params)
    redirect_to :back
  end

  def destroy
    @follow = FollowChannel.find(params[:user_id])
    @follow.destroy
  end

  private
  def follow_params
    params.require(:follow_channel).permit(:user_id, :channel_id)
  end
end
