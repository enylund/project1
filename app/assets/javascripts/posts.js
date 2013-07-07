var ready = (function () {

$("#create-new-post-form").hide();

 $("#new-post-symbol").on('click', function () {

   $("#create-new-post-form").slideToggle('fast');

 });


});


$(document).ready(ready);
$(document).on('page:load', ready)
