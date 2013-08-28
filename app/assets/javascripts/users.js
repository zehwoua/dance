// $( "#test" ).on( "submit", function( event ) {
//   event.preventDefault();
//   console.log( $(this).serialize() );
//   return false;
// });

$(document).ready(function(){
	$(".edit_avatar_link").click(function(e){
		e.preventDefault();
		if(!$(this).hasClass('active')){

			$(this).addClass('active');
			$("#display_profile_table").addClass('no_display');
			$("#change_avatar_table").removeClass('no_display').addClass('show_display');
		}	
	});
	$('#photocloseid').click(function(){
		$("#change_avatar_table").removeClass('show_display').addClass('no_display');
		$("#display_profile_table").removeClass('no_display');
		$(".edit_avatar_link").removeClass('active')
	});

	$(".edit_profile_link").click(function(e){
		e.preventDefault();
		if(!$(this).hasClass('active')){

			$(this).addClass('active');
			$("#display_profile_table").addClass('no_display');
			$("#change_profile_table").removeClass('no_display').addClass('show_display');
		}
	});
// 	// $.ajaxSetup({'beforeSend': function(xhr) {xhr.setRequestHeader("Accept",'');xhr.setRequestHeader("Accept", "text/javascript")}

// $("#test1").click(function(e){
// 	// e.stopPropagation();
// 	d = $('#test').serialize();
// 	alert(d);
//     e.preventDefault();
// 	$.ajax({
//         url: '/users/update_avatar',
//         type: 'put',
//         // dataType: 'xml',
//         data: $('#test').serialize(),
//         success: function(data) {
//               alert(data);
//               console.log( $(this).serialize() );
//         }
//     });
// });
});
