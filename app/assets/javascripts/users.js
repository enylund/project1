var ready = ( function() {

    $("#q").autocomplete({
      source: $('#q').data('autocomplete-source'),
      messages: {
        noResults: '',
        results: function() {}
                 }
    });

});

$(document).ready(ready);
$(document).on('page:load', ready);
