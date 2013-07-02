$(document).ready( function() {

    $("#q").autocomplete({
      source: $('#q').data('autocomplete-source'),
      messages: {
        noResults: '',
        results: function() {}
                 }
    });

});
