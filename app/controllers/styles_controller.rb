class StylesController < ApplicationController
  	def show
	  	@current_style_id = params[:id]
	  	@q = Video.search(params[:q])
	  	@videos = @q.result(distinct: true).page(params[:page]).per_page(3).where(:style_id => @current_style_id)
	   	@level = Level.all
	    @style = Style.find(@current_style_id)

	    respond_to do |format|
	      	format.html # show.html.erb
	      	format.json { render json: @style }
	      	format.js
	    end
  	end
end
