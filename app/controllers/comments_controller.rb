class CommentsController < ApplicationController

  # def create
  #           @comment = current_user.comments.new(comment_params)
  #           if !@comment.save
  #           	flash[:notice] = @comment.errors.full_messages.to_sentence
  #           end
  #           redirect_to post_path(params[:post_id])
  # end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:content)
      .merge(post_id: params[:post_id])
  end


  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(params[:post_id]), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, images: [])
  end

end
