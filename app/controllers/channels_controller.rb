class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_action :privacy_check, only: [:show, :edit, :update, :destroy]
  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.all
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
  @channel = Channel.find(params[:id])
  followers_count =  FollowChannel.count(:conditions => { :channel_id => params[:id] })
  @add_followers_to_view = false
  unless followers_count < 1
    array_of_channel_followers()
    @add_followers_to_view = true
  end
    if user_signed_in?
      @current_user_id = current_user.id
      @current_channel_id = params[:id].to_i
      @channel_creator_id = Channel.find(@current_channel_id).user_id
      if @channel_creator_id != @current_user_id
        @allowed_to_follow = true
        @test = FollowChannel.where(:user_id => @current_user_id, :channel_id => @current_channel_id)
      end
    end
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)

    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @channel }
      else
        format.html { render action: 'new' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy

    FollowChannel.where(:channel_id => params[:id]).destroy_all

    @channel.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.json { head :no_content }
    end
  end

  def array_of_channel_followers
    follow_rows = []
    follow_rows = FollowChannel.where(:channel_id => params[:id]).all
    followers_user_ids = []
    follow_rows.each do |row|
      followers_user_ids << row.user_id
    end
    @array_of_channel_followers = User.find(followers_user_ids)
    # raise @array_of_channel_followers.to_yaml
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    def privacy_check
      @channel = Channel.find(params[:id])
      privacy = @channel.privacy
      @postable = true
      if privacy == 'private' && (current_user != @channel.user)
        flash[:notice] = "This is a private channel. If you created this channel, please log in to view."
        redirect_to root_path
      elsif privacy == 'closed' && (current_user != @channel.user)
        @postable = false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:name, :description, :user_id, :privacy)
    end
end
