class  Admin::TeachersController < ApplicationController
	def index
		@search = Teacher.search(params[:q])
    	@teachers = @search.result
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
		        format.html { redirect_to admin_teachers_path, notice: 'teacher was successfully created.' }
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
		        format.html { redirect_to admin_teachers_path, notice: 'Teacher was successfully updated.' }
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
		    format.html { redirect_to admin_teachers_path }
		    format.json { head :no_content }
	    end
  	end
end
