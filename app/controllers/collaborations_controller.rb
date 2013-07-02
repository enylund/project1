class CollaborationsController < ApplicationController
  def create
    Collaboration.create(collaboration_params)
    redirect_to :back
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:channel_id, :user_id)
  end
end
