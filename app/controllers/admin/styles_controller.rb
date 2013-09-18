class Admin::StylesController < ApplicationController
	before_filter :authenticate_admin_user!
	def index
		@search = Style.search(params[:q])
    	@styles = @search.result
	end

	def new
	  	@style = Style.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @style }
	    end
	end

	def edit
	    @style = Style.find(params[:id])
	end

  	def create
	    @style = Style.new(params[:style])

	    respond_to do |format|
		    if @style.save
		        format.html { redirect_to admin_styles_path, notice: 'style was successfully created.' }
		        format.json { render json: @style, status: :created, location: @teacher }
		    else
		    	format.html {
		    	flash[:alert] = @style.errors.full_messages.join(".\n")
		    	render action: "new" 
		    	}		        
	      	end
	    end
  	end

  	def update
    	@style = Style.find(params[:id])

	    respond_to do |format|
	      	if @style.update_attributes(params[:style])
		        format.html { redirect_to admin_styles_path, notice: 'style was successfully updated.' }
		        format.json { head :no_content }
	      	else
		        format.html { render action: "edit" }
		        format.json { render json: @style.errors, status: :unprocessable_entity }
	      	end
	    end
  	end

  	def destroy
	    @style = Style.find(params[:id])
	    @style.destroy

	    respond_to do |format|
		    format.html { redirect_to admin_styles_path }
		    format.json { head :no_content }
	    end
  	end
  end