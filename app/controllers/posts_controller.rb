class PostsController < ApplicationController
	include ProfilesHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]
	protect_from_forgery :except => :vote

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
		@post.profile_id = current_profile.id
		respond_to do |format|
      if @post.save
        format.html { 
					flash[:success] = "New post created!"
					redirect_to profile_path(current_profile)
				}
        format.json { render :show, status: :created, location: @post }
      else
				format.js {}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

	def home
		respond_to do |format|
			if signed_in?
				format.html {
					@profile = current_profile
					if @profile.following.count == 0
						redirect_to discover_path
					else
						@post = Post.new
						@posts = current_profile.posts.build
						@feed_items = current_profile.feed.order(created_at: :desc)[0..19]
					end
				}

				format.js {
					page = params[:page].to_i
					offset = page * 20 - 1
					@post_count = offset + 1 - 20
					@feed_items = current_profile.feed.order(created_at: :desc)[(offset - 19)..offset]
				}
			end
		end
	end

	def vote
		@post = Post.find(params[:post])
		if !current_profile.liked? @post
			@post.liked_by current_profile
			if current_profile != @post.profile
				@notification = Notification.new
				@notification.notified_by_id = current_profile.id
				@notification.profile_id = @post.profile_id
				@notification.post_id = @post.id
				@notification.notification_type = "like"
				@notification.save
			end
		elsif current_profile.liked? @post
			@post.unliked_by current_profile
			if current_profile != @post.profile
				@notification = Notification.find_by(:profile_id => @post.profile_id, :notified_by => current_user.id, :post_id => @post.id, :notification_type => "like")
				@notification.destroy
			end
		end

		respond_to do |format|
			format.js {
			}
			format.json {}
			format.html {}
		end
	end

	def post_modal
		@post = Post.find(params[:post_id])
		@prev = params[:prev] if params[:prev].to_i >= 0	
		@next = params[:next] if params[:next].to_i >= 0
		respond_to do |format|
			format.html {}

			format.js {}
		end

	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:description, :image)
    end
end
