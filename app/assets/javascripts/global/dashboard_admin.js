// $(document).ready(function(){
// 	$(".approve_comment").click(function(e){
// 		e.preventDefault();
// 		var str = $(this).attr('id');
// 		comment_id = split_comment_id(str);
// 		video_id = split_video_id(str);
// 		pending_comment(video_id,comment_id,1);

// 	});

// 	$(".unapprove_comment").click(function(e){
// 		e.preventDefault();
// 		var str = $(this).attr('id');
// 		comment_id = split_comment_id(str);
// 		video_id = split_video_id(str);
// 		pending_comment(video_id,comment_id,0);
// 	});
// 	function split_comment_id(str){
// 		var substr = str.split('-');
// 		return substr[3];
// 	}
// 	function split_video_id(str){
// 		var substr = str.split('-');
// 		return substr[2];
// 	}

// 	function pending_comment(video_id, comment_id, status){
// 		alert(status);
// 		$.ajax({
// 	        url: '/admin/comments/'+ comment_id,
// 	        type: 'PUT',
// 	        data: {approved : status},
// 	        success: function(data) {
// 	        }
// 	    });
// 	}
// });