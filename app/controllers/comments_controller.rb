class CommentsController < ApplicationController
	include ApplicationHelper
	include ProfilesHelper
	before_action :logged_in_user
	before_action :correct_comment, only: [:destroy]
	def create
		@comment = Comment.new(comment_params)
		respond_to do |format|
			if @comment.save
					if current_profile != @comment.post.profile
						@notification = Notification.new
						@notification.notified_by_id = current_profile.id
						@notification.profile_id = @comment.post.profile_id
						@notification.post_id = @comment.post.id
						@notification.notification_type = "comment"
						@notification.save
					end
				format.html {
					#flash[:success] = "New comment posted!"
					#redirect_to home_path
				}
				format.json { 
					render json: @comment 
				}
				format.js {
			
				}
			end	
		end
	end

	def destroy 
		@comment = Comment.find(params[:comment_id])
		respond_to do |format|
			if current_profile != @comment.post.profile.id
				@notification = Notification.find_by(:notified_by_id => current_profile,
											:profile_id => @comment.post.profile.id,
											:post_id => @comment.post.id,
											:notification_type => "comment")
				
				@notification.destroy
			end
			@comment_id = @comment.id
			@comment.destroy
				format.html {
					#flash[:success] = "New comment posted!"
					#redirect_to home_path
				}
				format.json { 
					render json: @comment 
				}
				format.js {
			
				}
		end
	end

	def create_modal_comment
		@comment = Comment.new(comment_params)
		respond_to do |format|
			if @comment.save
				if current_profile != @comment.post.profile
						@notification = Notification.new
						@notification.notified_by_id = current_profile.id
						@notification.profile_id = @comment.post.profile_id
						@notification.post_id = @comment.post.id
						@notification.notification_type = "comment"
						@notification.save
				end

				format.html {
					#flash[:success] = "New comment posted!"
					#redirect_to home_path
				}
				format.json { 
					render json: @comment 
				}
				format.js {}
			end	
		end

	end

	def get_comments
		@post = Post.find(params[:post_id])
		page = params[:page].to_i
		@more = false
		respond_to do |format|
			if @post && !page.nil?
				format.json {
					offset = page * 5 - 1
					all_comments = @post.comments
					comments = all_comments.order(created_at: :desc)[(offset - 4)..offset]
					if all_comments.size > offset
						@more = true
					end
					render json: {comments: comments, more: true}
				}

				format.js {
					@post = Post.find(params[:post_id])
					page = params[:page].to_i
		@more = false

					offset = page * 5 - 1
					all_comments = @post.comments
					@comments = all_comments.order(created_at: :desc)[(offset - 4)..offset]
					if all_comments.size > offset + 1
						@more = true
					end
				}
			end
		end
	end
		
	def get_modal_comments
		@post = Post.find(params[:post_id])
		page = params[:page].to_i
		@more = false
		respond_to do |format|
			if @post && !page.nil?	
				format.js {
					offset = page * 10 - 1
					all_comments = @post.comments
					@comments = all_comments.order(created_at: :desc)[(offset - 9)..offset]
					if all_comments.size > offset + 1
						@more = true
					end
				}
			end
		end
	end

	def comment_params
		params.require(:comment).permit(:content, :profile_id, :post_id)
	end


	private

	def correct_comment
		@comment = Comment.find(params[:comment_id])
		redirect_to(root_url) unless current_profile == @comment.profile

	end
		
end


