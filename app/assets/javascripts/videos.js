(function() {
  jQuery(function checkPaginate() {
    if ($('.pagination').length) {
      $(window).scroll(function() {
        var url;
        url = $('.pagination .next_page').attr('href');
        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
          $('.pagination').html("<img src='assets/loader.gif'>");
          return $.getScript(url);
        }
      });
      return $(window).scroll();
    }
  });

}).call(this);
