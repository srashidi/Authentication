class PostsController < ApplicationController
	before_action :logged_in_user,	only: [:new, :create]

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	if @post.save
  		@post.save
			flash[:success] = "Post successfully created."
			redirect_to posts_url
		else
			render 'new'
		end
  end

  def index
  	@posts = Post.all
  end

  private

  	def logged_in_user
  		unless logged_in?
  			flash[:danger] = "Please log in."
  			redirect_to login_url
  		end
  	end

  	def post_params
  		params.require(:post).permit(:content, :user_id)
  	end
end
