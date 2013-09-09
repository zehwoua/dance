class LevelsController < ApplicationController	
  	def show
	  	@current_level_id = params[:id]
	  	@q = Video.search(params[:q])
	  	@videos = @q.result(distinct: true).page(params[:page]).per_page(3).where(:level_id => @current_level_id)
	    @level = Level.find(@current_level_id)

	    respond_to do |format|
	      	format.html # show.html.erb
	      	format.json { render json: @level }
	      	format.js
	    end
  	end
end
