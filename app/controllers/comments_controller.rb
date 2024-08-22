class CommentsController < ApplicationController
  # before_action :set_comment, only: %i[update destroy]
   before_action :set_post, only: [:create, :new]
  before_action :set_comment, only: [:update]
  @likeable = @comment

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.build(comment_params)
 @comment.parent_id = params[:comment_id] if params[:comment_id].present?
    if params[:comment_id] # If it's a reply
      @comment.parent_id = params[:comment_id]
    end

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
      end
    else
      render 'posts/show' # Render the show page if validation fails
    end
  end

  # GET /posts/:post_id/comments/ :comment_id/replies/new
  def new
    @reply_to = Comment.find(params[:comment_id])
    @comment = @post.comments.build(parent: @reply_to)
    
    render partial: 'comments/form', locals: { post: @post, reply_to: @reply_to }
  end


  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  private


  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # def set_comment
  #   @comment = Comment.find(params[:id])
  # end

  def comment_params
    params.require(:comment).permit(:content, images: []).merge(post_id: params[:post_id], user_id: current_user.id)
  end
end

