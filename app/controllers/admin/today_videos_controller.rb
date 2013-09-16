class Admin::TodayVideosController < ApplicationController
	# before_filter :load_video
	# before_filter :authenticate_user!, except: [:index, :show]

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

	# def index
	# 	@search = Comment.search(params[:q])
	# 	if params[:sort].present?
	# 		if params[:sort] == '3'
	# 			@comments = @search.result.where(:approved => nil)
	# 			@active = "pending"
	# 		else
	# 			@comments = @search.result.where(:approved => params[:sort])
	# 			if params[:sort] == '1'
	# 				@active = "approved"
	# 			else
	# 				@active = "unapproved"
	# 			end
	# 		end
	# 	else
	# 		@comments = @search.result
	# 		@active = "all"
	# 	end
	# end

	# def edit
	# 	@comment = Comment.find(params[:id])
 #  	end

  	

 #  	def destroy
	# 	@comment = Comment.find(params[:id])
	# 	@comment.destroy
	# 	redirect_to admin_comments_path, notice: "Comment is successfully destroyed."
	# end

# private

#   def load_video
#     @video = Video.find(params[:video_id])
#   end
end
