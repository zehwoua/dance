module VideosHelper
	def get_favorite_video(id)
		@popular_videos = Video.find(id)
		return @popular_videos
	end
end
