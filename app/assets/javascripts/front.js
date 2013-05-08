// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery(function ($) {
  "use strict";

  if ($("#home").length == 0) { return; } // Only run on homepage

  function updateOpenInMobileImage() {
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
    throttleTimer = setTimeout(updateOpenInMobileImage, 100);
  });

  updateOpenInMobileImage();

  // Gmaps4Rails update markers based on window
  function updateMarkers() {
    //Gmaps.map.adjustMapToBounds();

    var sw = Gmaps.map.map.getBounds().getSouthWest();
    var ne = Gmaps.map.map.getBounds().getNorthEast();

    console.log(sw) // debug log - these coordinates are changing after each marker replacement

    var data = {"northEast": ne.toUrlValue(15), "southWest": sw.toUrlValue(15)};

    $.getJSON('/reports.json', data, function(json){

      Gmaps.map.replaceMarkers(json);
    });
  }

  Gmaps.map.callback = function() {

    // Map fully loaded here
    google.maps.event.addListenerOnce(Gmaps.map.serviceObject, 'idle', updateMarkers);

    google.maps.event.addListener(Gmaps.map.serviceObject, 'bounds_changed', updateMarkers);
  }

});
