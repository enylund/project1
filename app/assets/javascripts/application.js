// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.autocomplete
//= require jquery.ui.all
//= require turbolinks
//= require_tree .
//= require jquery.tokeninput


$(document).ready( function() {
  $("#application-search-nav").hide();
   $("#application-channel-add").click(function () {
      $("#application-search-nav").slideToggle("fast");
   });

  $('#jump-symbol').hide();

  $(window).scroll(function () {

    var userInfo = $(window).height();


    var posit = $(window).scrollTop();
    console.log(posit);

    if (posit > userInfo) {
      $('#jump-symbol').fadeIn();
    } else {
      $('#jump-symbol').fadeOut();
    }
  });

  $('#jump-symbol').on('click', function() {
    $("body").animate({scrollTop:0}, "slow");
  });




});
