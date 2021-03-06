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
//= require_tree ./global

// $(function(){
//   $('a.video_popover').popover({
//       html: true,
//       delay: { show: 500, hide: 100 }
//     });
//   // $('a.video_popover').click(function(e){
//   //   e.preventDefault();
//   // })

//   // function test(x){
//   //   var return_result = "";
//   //   var id = "";
//   //   id = x.attr('id').match(/\d+/);
    
//   //   $.ajax({
//   //     url: "/videos/"+id[0]+".json",
//   //     dataType: 'json',
//   //     type: 'get',
//   //     async:false,
//   //     success: function(data){
//   //       return_result = data
//   //     }
//   //   });
//   //   return return_result;
//   // }
//   $('a.video_popover').hover(function(){
//     // var popover_content = ""; 
//     // c = test($(this));
//     // popover_content = c.title;
//     // // console.log(c.title);
    
//   });
  
// });

$(document).ready(function() {
    $("body").removeClass("preload");

    $( ".dashboard_inner_tab" ).tabs();

    
    duration_value = 0;
    duration_value = $("#duration_hidden").val();

    if($("#duration_hidden").hasClass("hidden_scale_slider")){
      max = 10;
    }else{
      max = 120;
    }
    
    if(!duration_value){
      if($("#duration_hidden").hasClass("new_slider")){
        duration_value = 0;
      }else{
        duration_value = 120;
      }
    }
    
    $("#duration_slider_result").html( duration_value );

    $( ".duration_slider" ).slider({
      animate: true,
      range: "min",
      value: duration_value,
      min: 0,
      max: max,
      step: 1,
    
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

    $("#flashclose").click(function(){
      $(this).parents('.notify-bar').slideUp();
    });

    $("#class_filter").click(function(e){
      e.preventDefault();
      $("#search_section").slideToggle('fast');
      if ( $(this).hasClass('active_search')) {
        $(this).removeClass('active_search');
        $(this).find('span.glyphicon-chevron-down').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-right');
      }else{
        $(this).addClass('active_search');
        $(this).find('span.glyphicon-chevron-right').removeClass('glyphicon-chevron-right').addClass('glyphicon-chevron-down');
      }
    })
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
    $.get($("#video_search_form").attr("action"), $("#video_search_form").serialize(), null, "script");
    checkPaginate();
    return false;
  });

  $("#video_search_form input").keyup(function() {
    $.get($("#video_search_form").attr("action"), $("#video_search_form").serialize(), null, "script");
    return false;
  });

  $(".add_user_notes_form textarea").keyup(function() {
    var note_form = $(this).parent();
    $.post(note_form.attr("action"), note_form.serialize(), null, "script");
    return false;
  });

  subs = $("#select_plan_section");
  content = subs.html();

  $("input[name='user[customer_type]']").change(function(){
    type = $("input[name='user[customer_type]']:checked").val();
    
    if (type == 'free'){
        $("#select_plan_section").empty();
    }else{
      $("#select_plan_section").append(content);
    }
  });

 });