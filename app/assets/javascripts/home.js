// $(document).ready(function(){
//   $('.bxslider').bxSlider({
//   	auto: true,
//   	autoControls: true,
//   	pause: 10000
//   });
// });

$(document).ready(function(){
	$(".display_videos_module").find('.video-container').each(function(){
    	alert(hey);
    });

    // new AnimOnScroll( document.getElementById( 'video_listing' ), {
    //     minDuration : 0.4,
    //     maxDuration : 0.7,
    //     viewportFactor : 0.2
    // } );

    var options = {
        nextButton: true,
        prevButton: true,
        pagination: true,
        animateStartingFrameIn: true,
        autoPlay: true,
        autoPlayDelay: 100000000,
        preloader: true,
        preloadTheseFrames: [1],
        preloadTheseImages: [
            "images/tn-model1.png",
            "images/tn-model2.png",
            "images/tn-model3.png"
        ]
    };
    
    var mySequence = $("#sequence").sequence(options).data("sequence");
});