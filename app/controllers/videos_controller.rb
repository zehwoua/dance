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

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        format.html { redirect_to admin_videos_path, notice: 'Video was successfully created.' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to admin_videos_path, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
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
