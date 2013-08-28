class CommentsController < ApplicationController
	before_filter :load_video
	before_filter :authenticate_user!, except: [:index, :show]

	def create
		@comment = @video.comments.build(params[:comment])
		@comment.user = current_user
		if @comment.save
			redirect_to @video, notice: "Comment was created."
		else
			render :new
		end
	end

	def edit
		@comment = current_user.comments.find(params[:id])
  	end

  	def update
  		@comment = current_user.comments.find(params[:id])
  		if @comment.update_attributes(params[:comment])
  			redirect_to @video, notice: "comment was updated."
  		else
  			render :edit
  		end	  		
  	end

  	def destroy
		@comment = current_user.comments.find(params[:id])
		@comment.destroy
		redirect_to @video, notice: "Comment was destroyed."
	end

private

  def load_video
    @video = Video.find(params[:video_id])
  end
end
