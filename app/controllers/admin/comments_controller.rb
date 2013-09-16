class Admin::CommentsController < ApplicationController
	# before_filter :load_video
	# before_filter :authenticate_user!, except: [:index, :show]

	# def create
	# 	@comment = @video.comments.build(params[:comment])
	# 	@comment.user = current_user
	# 	if @comment.save
	# 		redirect_to @video, notice: "Comment was created."
	# 	else
	# 		render :new
	# 	end
	# end
	def index
		@search = Comment.search(params[:q])
    	@comments = @search.result
	end

	def edit
		@comment = Comment.find(params[:id])
  	end

  	def approve_comments
  		@comment = Comment.find(params[:id])

  		respond_to do |format|
	  		if @comment.update_attributes(:approved => params[:approved])
	  			format.html {redirect_to admin_comments_path, notice: "Comment is successfully updated."}
	  			format.js {head :no_content }
	  			format.json {}
	  		else
	  			format.html {render :edit}
	  			format.js {head :no_content }
	  			format.json {}
	  		end	  
	  	end
  	end

  	def update
  		@comment = Comment.find(params[:id])

  		respond_to do |format|
	  		if @comment.update_attributes(params[:comment])
	  			format.html {redirect_to admin_comments_path, notice: "Comment is successfully updated."}
	  			format.js {head :no_content }
	  			format.json {}
	  		else
	  			format.html {render :edit}
	  			format.js {head :no_content }
	  			format.json {}
	  		end	  
	  	end 		
  	end

  	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to admin_comments_path, notice: "Comment is successfully destroyed."
	end

# private

#   def load_video
#     @video = Video.find(params[:video_id])
#   end
end
