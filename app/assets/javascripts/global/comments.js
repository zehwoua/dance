$(document).ready(function(){
	$(".approve_comment, .unapprove_comment").click(function(e){
		e.preventDefault();
		var id = $(this).attr('data-rel');
		$("#"+id).fadeOut('normal', function(){
			$(this).remove();
			if (count_comments() <= 5){
				$("#see_all_comments").parent().remove();
			}
		});
	});

	function count_comments(){
		return $('.listed_comments').length;
	}
});