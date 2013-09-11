class TeachersController < ApplicationController
  	def show
	  	@current_teacher_id = params[:id]
	  	@q = Video.search(params[:q])
	  	@videos = @q.result(distinct: true).page(params[:page]).per_page(3).where(:teacher_id => @current_teacher_id)
	  	@level = Level.all
	    @teacher = Teacher.find(@current_teacher_id)

	    respond_to do |format|
	      	format.html # show.html.erb
	      	format.json { render json: @teacher }
	      	format.js
	    end
  	end
end
