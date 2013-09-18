class Admin::TodayVideosController < ApplicationController
	before_filter :authenticate_admin_user!

	def create
		@video_exist = TodayVideo.where(:set_date => params[:today_video][:set_date])
		if @video_exist.count == 0
			@today_video = TodayVideo.create!(params[:today_video])
			respond_to do |format|
				if @today_video.save
					format.html {redirect_to admin_videos_path, notice: "Video date is successfully set"}
		  			format.js {head :no_content }
		  			format.json {}
				else
					format.html {render :new}
		  			format.js {head :no_content }
		  			format.json {}
				end
			end
		else
			@today_video = TodayVideo.find(@video_exist.first.id)
			respond_to do |format|
		  		if @today_video.update_attributes(params[:today_video])
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
	end

	def update
  		@today_video = TodayVideo.find(params[:id])

  		respond_to do |format|
	  		if @today_video.update_attributes(params[:today_video])
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
end
