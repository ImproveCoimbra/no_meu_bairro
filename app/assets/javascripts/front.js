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

  var currentBounds;

  // Gmaps4Rails update markers based on window
    function updateMarkers() {
        //Gmaps.map.adjustMapToBounds();
        var bounds= Gmaps.map.map.getBounds();

        var sw = bounds.getSouthWest();
        var ne = bounds.getNorthEast();

        // || (currentBounds.contains(sw) && currentBounds.contains(ne))
        if (currentBounds != null &&
            (currentBounds.contains(sw) && currentBounds.contains(ne)) ) {
            //Nothing to do
            return;
        }

        console.log("Current SW" + sw); // debug log - these coordinates are changing after each marker replacement
        console.log("Current NE" + ne); // debug log - these coordinates are changing after each marker replacement

        //Generic function could be simplified
        var latDiff = Math.sqrt((sw.lat() - ne.lat()) ^ 2);
        var lngDiff = Math.sqrt((sw.lng() - ne.lng()) ^ 2);

        //Move the corners in the direction by half the size
        bounds = new google.maps.LatLngBounds(
            new google.maps.LatLng(sw.lat() - latDiff/2, sw.lng() - lngDiff/2),
            new google.maps.LatLng(ne.lat() + latDiff/2, ne.lng() + lngDiff/2)
        );

        sw = bounds.getSouthWest();
        ne = bounds.getNorthEast();

        currentBounds = bounds;
        console.log("SW" + sw); // debug log - these coordinates are changing after each marker replacement
        console.log("NE" + ne); // debug log - these coordinates are changing after each marker replacement

        var data = {"northEast": ne.toUrlValue(15), "southWest": sw.toUrlValue(15)};

        $.getJSON('/reports.json', data, function (json) {

            Gmaps.map.replaceMarkers(json, false);
        });
    }

  Gmaps.map.callback = function() {

    // Map fully loaded here
    google.maps.event.addListenerOnce(Gmaps.map.serviceObject, 'idle', updateMarkers);

    google.maps.event.addListener(Gmaps.map.serviceObject, 'bounds_changed', updateMarkers);
  }

});
