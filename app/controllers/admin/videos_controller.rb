class Admin::VideosController < ApplicationController
 def index_admin
    @videos = Video.all
  end
end
