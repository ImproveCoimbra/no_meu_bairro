$(document).ready(function () {

    var loading_location_message = $("#loading_location_message");
    loading_location_message.hide();
    loading_location_message.css("visibility", "visible");
    var location_found_message = $("#location_found_message");
    location_found_message.hide();
    location_found_message.css("visibility", "visible");
    var location_not_found_message = $("#location_not_found_message");
    location_not_found_message.hide();
    location_not_found_message.css("visibility", "visible");


    function findLocation() {
        loading_location_message.show(500);
        location_not_found_message.hide(500);

        navigator.geolocation.getCurrentPosition(
            foundLocation,
            noLocation,
            { enableHighAccuracy: true, timeout: 30000, maximumAge: 0 }
        );
    }

    function foundLocation(position) {
        loading_location_message.hide(500);
        location_found_message.show(500);

        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;
        document.getElementById('latitude').value = latitude;
        document.getElementById('longitude').value = longitude;

    }

    function noLocation() {
        loading_location_message.hide(500);
        location_not_found_message.show(500);
    }

    if ($('form#new_report').length > 0) {
        findLocation();
    }

});
