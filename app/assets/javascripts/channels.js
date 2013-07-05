$(document).ready( function () {

$('#expand-symbol').on('click', function() {

    if ($('#channel-info-hide').is(":hidden")) {
        $("#expand-symbol").empty().html(" &#11033;");
      } else {
        $("#expand-symbol").empty().html(" &#11031;");
      }

    $('#channel-info-hide').slideToggle();

  });
});
