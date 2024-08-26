class LikesController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def create
    @like = current_user.likes.new(like_params)

    @like.kind = params[:kind] || 'thumb_up'

   
      if @like.save
        flash.now[:notice] = 'Liked!'
      else
        flash.now[:alert] = 'Unable to like.'
        redirect_to @like.likeable
      end
    end

   
  
  def destroy

    #@like = Like.find(params[:id])
    @like = current_user.likes.find(params[:id])
    likeable = @like.likeable
    @like.destroy
     redirect_to likeable
  end

  private


  def like_params
         params.require(:like).permit(:likeable_id,:likeable_type)
  end

  
end
