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
  @title = @channel.user.username + "'s " + @channel.name + " channel"
  # followers_count =  FollowChannel.count(:conditions => { :channel_id => params[:id] })
  followers_count =  FollowChannel.where(channel_id: params[:id]).count
  @collaborators = @channel.collaborations
  @add_followers_to_view = false
  unless followers_count < 1
    @chan_fols = FollowChannel.where(channel_id: @channel.id)
    @add_followers_to_view = true
  end
    if user_signed_in?
      if @channel.user != current_user
        @allowed_to_follow = true
        @test = FollowChannel.where(:user_id => current_user.id, :channel_id => params[:id])
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
    @channel.user = current_user
    @channel.save

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    def privacy_check
      privacy = @channel.privacy
      @postable = true

      if Collaboration.where(channel: @channel, user: current_user).blank?
        a_collab = false
      else
        a_collab = true
      end

      if !@channel.visible_to?(current_user) && !a_collab
        flash[:notice] = "This is a private channel. If you have permission, please log in to view."
        redirect_to root_path
      elsif privacy == 'closed' && (current_user != @channel.user)
        @closed = true
        @postable = false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:name, :description, :privacy)
    end
end
