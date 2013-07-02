class CollaborationsController < ApplicationController
  def create
    the_chan = collaboration_params[:channel_id]
    the_user = collaboration_params[:user_id]

    if Collaboration.where(channel_id: the_chan, user_id: the_user).blank?
      Collaboration.create(collaboration_params)
      redirect_to :back
    else
      flash[:notice] = "This person is already a collaborator."
      redirect_to :back
    end
  end

  def destroy
    Collaboration.destroy_all( id: params[:id] )
    redirect_to :back
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:channel_id, :user_id)
  end
end
