class LikesController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def create
    @likeable = find_likeable
    @like = current_user.likes.find_or_initialize_by(likeable: @likeable)

    @like.kind = params[:kind] || 'thumb_up'

    if @like.new_record?
      if @like.save
        flash.now[:notice] = 'Liked!'
      else
        flash.now[:alert] = 'Unable to like.'
      end
    else
      @like.destroy
      flash.now[:notice] = 'Unliked!'
    end

    respond_to do |format|
      format.js # This will look for create.js.erb or destroy.js.erb for AJAX requests
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.js # This will look for destroy.js.erb for AJAX requests
    end
  end

  private

  def find_likeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
