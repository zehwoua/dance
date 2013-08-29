// // This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.sequence-min
//= require twitter/bootstrap
//= require fancybox
//= require rails.validations


$(document).ready(function() {
  	$("body").removeClass("preload");

  	$( ".duration_slider" ).slider({
		animate: true,
	   	range: "min",
	   	value: 120,
	   	min: 5,
	   	max: 120,
	   	step: 5,
    
	   	//this gets a live reading of the value and prints it on the page
	   	slide: function( event, ui ) {
	       $( "#duration_slider_result" ).html( ui.value );
   		},

	   	//this updates the hidden form field so we can submit the data using a form
	   	change: function(event, ui) {
	   		$('#duration_hidden').attr('value', ui.value);
	   		$.get($("#video_search_form").attr("action"), $("#video_search_form").serialize(), null, "script");
    		return false;
   		}

   });
  	$(".level_eq_search").change(function(){
      var id = $(this).attr("id");
      label = $('label[for='+id+']');
      if(label.hasClass('checked')){
        label.removeClass('checked');
      }else{
        label.addClass('checked');
      }	    
	});

  $("#q_style_id_eq, #q_teacher_id_eq, .level_eq_search").change(function() {
    console.log($("#video_search_form").serialize());
    $.get($("#video_search_form").attr("action"), $("#video_search_form").serialize(), null, "script");
    return false;
  });

  $("#video_search_form input").keyup(function() {
    $.get($("#video_search_form").attr("action"), $("#video_search_form").serialize(), null, "script");
    return false;
  });
 });