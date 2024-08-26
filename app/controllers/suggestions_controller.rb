class SuggestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: [:create]

    before_action :set_suggestion, only: [:edit, :update, :destroy, :reply, :accept, :reject]
    
    load_and_authorize_resource through: :post, except: :index
    load_and_authorize_resource only: :index  
    def index
      if params[:post_id]
        # List all suggestions for a specific post
        @suggestions = @post.suggestions.where(status: ['pending', 'accepted'])

      else
        # List all suggestions made by the current user
        @suggestions = Suggestion.where(user_id: current_user.id).where.not(status: :rejected)
       end
    end
  
    def create
        
      @suggestion = @post.suggestions.build(suggestion_params)
      @suggestion.user = current_user
  
      if @suggestion.save
        redirect_to post_path(@post), notice: 'Suggestion created successfully.'
      else
        render 'posts/show', status: :unprocessable_entity
      end
    end
  
    def edit
      # The form for editing the suggestion will be rendered
    end
  
    def update
      if @suggestion.update(suggestion_params)
        redirect_to post_path(@suggestion.post), notice: 'Suggestion updated successfully.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @suggestion.destroy
      redirect_to post_path(@suggestion.post), notice: 'Suggestion was successfully deleted.'
    end
  
    def reply
        authorize! :reply, @suggestion
      @reply = @suggestion.replies.build(suggestion_params)
      @reply.user = current_user
      @reply.post = @suggestion.post
  
      if @reply.save
        redirect_to post_path(@suggestion.post), notice: 'Reply added successfully.'
      else
        render 'posts/show', status: :unprocessable_entity
      end
    end
  
    def accept
      authorize! :accept, @suggestion  # Check if the user can accept the suggestion
  
      if @suggestion.update(status: :accepted)
        redirect_to edit_post_path(@suggestion.post), notice: 'Suggestion accepted successfully.'
      else
        render :index, status: :unprocessable_entity
      end
    end
  
    def reject
      authorize! :reject, @suggestion  # Check if the user can reject the suggestion
      if @suggestion.update(status: :rejected)
        redirect_to post_path(@suggestion.post), notice: 'Suggestion rejected successfully.'
      else  
        render :index, status: :unprocessable_entity
      end
      # Logic for rejecting the suggestion
    end
  
    private
  
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def suggestion_params
      params.require(:suggestion).permit(:content, :status, :parent_id)
    end
  end
  