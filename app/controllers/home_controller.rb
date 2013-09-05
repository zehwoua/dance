class HomeController < ApplicationController
  def index
  	@q = Video.search(params[:q])
   	@videos = @q.result(distinct: true).page(params[:page]).per_page(3)
   	@level = Level.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
      format.js
    end
  end
  def subscription
  	@plans = BraintreeRails::Plan.all
  end
end
