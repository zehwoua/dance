class HistoryVideosController < ApplicationController
	before_filter :authenticate_user!
	def create
		@video = Video.find(params[:video_id])
		@history_video = current_user.history_videos.create!(:video_id => params[:video_id])
		
		respond_to do |format|
			if @history_video.save
			    format.json {head :no_content}
			else
        		format.json { render json: @video.errors, status: :unprocessable_entity }
		    end
		end
	end
end
