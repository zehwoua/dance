class Admin::VideosController < ApplicationController
 def index_admin
    @videos = Video.all
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

   # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to admin_videos_path }
      format.json { head :no_content }
    end
  end
end
