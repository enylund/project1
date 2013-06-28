class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_privacy, :except => [:create]

  # GET /posts
  # GET /posts.json
  # def index
  #   @posts = Post.all
  # end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @title = "Post by " + @post.user.username + " on " + @post.channel.name
  end

  # GET /posts/new
  # def new
  #   @post = Post.new
  # end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @channel = Channel.find(params[:post][:channel_id])
    if @channel.visible_to?(current_user)
      @post = Post.create(post_params)
      @post.user = current_user
      @post.save
      redirect_to @post.channel
    else
      redirect_to :root, notice: "Stop it yo"
    end
  end

    # respond_to do |format|
    #   if @post.save
    #     format.html { redirect_to @post, notice: 'Post was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @post }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:img_url, :caption, :channel_id, :postimage)
    end

    def check_privacy
      redirect_to :root and return unless @post.visible_to?(current_user)
    end
end
