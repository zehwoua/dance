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
		        format.html { redirect_to @style, notice: 'style was successfully created.' }
		        format.json { render json: @style, status: :created, location: @teacher }
		    else
		        format.html { render action: "new" }
		        format.json { render json: @style.errors, status: :unprocessable_entity }
	      	end
	    end
  	end

  	def update
    	@style = Style.find(params[:id])

	    respond_to do |format|
	      	if @style.update_attributes(params[:style])
		        format.html { redirect_to @style, notice: 'style was successfully updated.' }
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
		    format.html { redirect_to videos_url }
		    format.json { head :no_content }
	    end
  	end
end
