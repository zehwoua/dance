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

	def new
	  	@teacher = Teacher.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @teacher }
	    end
	end

	def edit
	    @teacher = Teacher.find(params[:id])
	end

  	def create
	    @teacher = Teacher.new(params[:teacher])

	    respond_to do |format|
		    if @teacher.save
		        format.html { redirect_to @teacher, notice: 'teacher was successfully created.' }
		        format.json { render json: @teacher, status: :created, location: @teacher }
		    else
		        format.html { render action: "new" }
		        format.json { render json: @teacher.errors, status: :unprocessable_entity }
	      	end
	    end
  	end

  	def update
    	@teacher = Teacher.find(params[:id])

	    respond_to do |format|
	      	if @teacher.update_attributes(params[:teacher])
		        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
		        format.json { head :no_content }
	      	else
		        format.html { render action: "edit" }
		        format.json { render json: @teacher.errors, status: :unprocessable_entity }
	      	end
	    end
  	end

  	def destroy
	    @teacher = Teacher.find(params[:id])
	    @teacher.destroy

	    respond_to do |format|
		    format.html { redirect_to videos_url }
		    format.json { head :no_content }
	    end
  	end
end
