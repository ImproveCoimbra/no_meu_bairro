// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery(function ($) {
  "use strict";

  if ($("#home").length == 0) { return; } // Only run on homepage

  function update() {
    var height = Math.min($(window).height() * 0.8, $(window).width() * 0.8);
    var width  = height;

    $('.modal-fluid img').css("height", height);
    $('.modal-fluid img').css("width", width);
    $('.modal-fluid').css("width", width);
    $('.modal-fluid').css("height", height);
    $('.modal-fluid').css("left", $(window).width()/2 - $('.modal-fluid').width()/2);
  }

  var throttleTimer;
  $(window).resize(function(){
    clearTimeout(throttleTimer);
    throttleTimer = setTimeout(update, 100);
  });

  update();
});
