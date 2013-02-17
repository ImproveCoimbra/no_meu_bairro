/* globals jQuery, Gmaps */
jQuery(function ($) {
  "use strict";

  if ($("#home").length == 0) { return; }

  var jQueryCache, headerHeight, footerHeight, ajdustSize, lastHeight;

  jQueryCache = {
    'window' : $(window),
    '.gmaps4rails_map, .map-container' : $('.gmaps4rails_map, .map-container'),
    'header' : $('header'),
    'footer' : $('footer')
  };

  headerHeight = jQueryCache.header.outerHeight();
  footerHeight = jQueryCache.footer.outerHeight();

  ajdustSize = function () {
    var height, windowHeight;

    windowHeight = jQueryCache.window.height();
    height = windowHeight - headerHeight - footerHeight;

    if (windowHeight === lastHeight || height < 200) {
        //If the height does not change bail out
        return;
    }

    lastHeight = windowHeight;

    jQueryCache['.gmaps4rails_map, .map-container'].css('height', height + 'px');
  };

  ajdustSize();

  //Probably we should throtle this
  jQueryCache.window.bind('resize', ajdustSize);

});
