class VideosController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :membership_required

  # GET /videos
  # GET /videos.json
  def index
  # @videos = Video.page(params[:page]).per_page(3)

   @q = Video.search(params[:q])
   @videos = @q.result(distinct: true).page(params[:page]).per_page(3)
   @level_value = ["1","2","3"]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
      format.js
      #  do
      #   @loaded_video = render
      # end
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])
    @popular = FavoriteVideo.most_favorite_videos
    @latest_comments = Comment.latest_comment
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end
end
