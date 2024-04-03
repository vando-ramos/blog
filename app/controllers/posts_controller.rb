class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[new edit create update destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def search
    @posts = Post.search(search_params[:q])
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        flash.now[:alert] = @post.errors.full_messages.to_sentence
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :author, :body)
    end

    def search_params
      params.permit(:q)
    end
end
