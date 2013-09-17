$(document).ready(function(){
	$(".calendar td").click(function(){
		calendar = $(this);
		if(calendar.hasClass('disabled_days')) return false;
		setTimeout(function() {
		    remove_selected();
		    calendar.addClass('selected');
		    full_hidden_date = calendar.find('.full_hidden_date')
		    full_date = full_hidden_date.attr('id');
		    if(full_hidden_date.hasClass('set')){

		    }
			$('#display_today_video .full_date').html(full_date);
			$('#today_video_set_date').val(full_date);
			
			// $('#new_today_video').hide();
			// $('#calendar_form_loader_image').show();
		}, 100);
		show_loader();
		setTimeout(function() {	
			hide_loader();
		},700);
		
	});
	function show_loader(){
		$('#new_today_video').hide();
		$('#calendar_form_loader_image').show();
		
	}
	function hide_loader(){
		$('#calendar_form_loader_image').hide();
		$('#new_today_video').show();
	}
	function remove_selected(){
		$(".calendar td").each(function(){
			if($(this).hasClass('selected')){
				$(this).removeClass('selected');
			}
		});
	}
	$('#submit_today_video').click(function(){
		selected_video = $('#new_today_video input[name="today_video[video_id]"]:checked').parent().text();
		if(!selected_video){
			append_message($(this),"Please select a video");
			return false;
		}
		$(".calendar td.selected p").html("<span class='text-primary'>"+selected_video+"</span>");
		append_message($(this),"The video is added.");
	});

	function append_message(button,message){
		button.parent().append('<span id="message" class="text-success">'+message+'</span>');
		setTimeout(function() {	
			$("#message").fadeOut('slow',function(){
				$(this).remove();
			});
		},1500);
	}
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
});