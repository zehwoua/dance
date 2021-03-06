class FavoriteVideosController < ApplicationController
	before_filter :authenticate_user!
	def create
		@video = Video.find(params[:video_id])
	    @favorite_video = current_user.favorite_videos.create!(:video_id => params[:video_id])
	    respond_to do |format|
			format.html 
			format.js
		end
	end

	def update
	 	@favorite = FavoriteVideo.find(params[:id])

	  	respond_to do |format|
		    if @favorite.update_attributes(params[:favorite_video])
		       format.html { redirect_to user_my_classes_path, notice: 'Post was successfully updated.' }
		       format.json { head :no_content } # 204 No Content
		    else
		      format.html { render action: "edit" }
		      format.json { render json: @post.errors, status: :unprocessable_entity }
		    end
	  	end
	end

	def destroy
		@video = Video.find(params[:id])
		@favorite_video = current_user.favorite_videos.find_by_video_id(params[:id])
		@favorite_video.destroy
		respond_to do |format|
			format.html 
			format.js
		end
	end
end
