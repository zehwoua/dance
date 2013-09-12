(function() {
  jQuery(function() {
    var states;
    $('#credit_card_billing_address_region').parent().parent().hide();
    states = $('#credit_card_billing_address_region').html();
    $('#credit_card_billing_address_country_code_alpha2').change(function() {
      var country, escaped_country, options;
      country = $('#credit_card_billing_address_country_code_alpha2 :selected').text();
      escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
      options = $(states).filter("optgroup[label=" + escaped_country + "]").html();
      if (options) {
        $('#credit_card_billing_address_region').html(options);
        return $('#credit_card_billing_address_region').parent().parent().show();
      } else {
        $('#credit_card_billing_address_region').empty();
        return $('#credit_card_billing_address_region').parent().parent().hide();
      }
    });
    return $('#credit_card_billing_address_country_code_alpha2').change();
  });

}).call(this);
