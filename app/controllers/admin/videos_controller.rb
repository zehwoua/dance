class Admin::VideosController < ApplicationController
 def index_admin
    @videos = Video.all
  end

   # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end
end
