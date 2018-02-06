class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		respond_to do |format|
			if @comment.save
				format.html {
					#flash[:success] = "New comment posted!"
					#redirect_to home_path
				}
				format.json { 
					render json: @comment 
				}
				format.js {
					@notification = Notification.new
					@notification.notified_by_id = current_profile.id
					@notification.profile_id = @comment.post.profile_id
					@notification.post_id = @comment.post.id
					@notification.notification_type = "comment"
				}
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
					if all_comments.size > offset
						@more = true
					end
				}
			end
		end
	end

	def comment_params
		params.require(:comment).permit(:content, :profile_id, :post_id)
	end
end