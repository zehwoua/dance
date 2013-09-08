class LevelsController < ApplicationController
	def index
		@levels = Level.all
	end
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

	def new
	  	@level = Level.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @level }
	    end
	end

	def edit
	    @level = Level.find(params[:id])
	end

  	def create
	    @level = Level.new(params[:level])

	    respond_to do |format|
		    if @level.save
		        format.html { redirect_to admin_levels_path, notice: 'level was successfully created.' }
		        format.json { render json: @level, status: :created, location: @teacher }
		    else
		        format.html { render action: "new" }
		        format.json { render json: @level.errors, status: :unprocessable_entity }
	      	end
	    end
  	end

  	def update
    	@level = Level.find(params[:id])

	    respond_to do |format|
	      	if @level.update_attributes(params[:level])
		        format.html { redirect_to admin_levels_path, notice: 'level was successfully updated.' }
		        format.json { head :no_content }
	      	else
		        format.html { render action: "edit" }
		        format.json { render json: @level.errors, status: :unprocessable_entity }
	      	end
	    end
  	end

  	def destroy
	    @level = Level.find(params[:id])
	    @level.destroy

	    respond_to do |format|
		    format.html { redirect_to admin_levels_path }
		    format.json { head :no_content }
	    end
  	end
end
