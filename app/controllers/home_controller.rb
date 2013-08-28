class HomeController < ApplicationController
  def index
  	@videos = Video.page(params[:page]).per_page(3)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
      format.js
    end
  end
end
