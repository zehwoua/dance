$(document).ready(function(){
	if($('body').hasClass('videos show')){
		//getting video id from the target div
		var wistia_id  = $(".wistia_embed").attr("data-wistia-id");
		var video_id  = $(".wistia_embed").attr("data-video-id");
		wistiaEmbed = Wistia.embed(wistia_id, {
		  version: "v1",
		  videoWidth: 640,
		  videoHeight: 360,
		  playerColor: "dd4814"
		});
		// insert the 'end' function
		wistiaEmbed.bind('end', function() {
		  // use the .time() method to jump ahead 10 seconds
		  create_history(video_id);
		  return this.unbind;
		});
		function create_history(video_id){
			id = video_id
			$.ajax({
			    url: '/history_videos',
			    type: 'POST',
			    data: 'video_id='+id,
			    success: function() {
			    }
			});
		}
	}
});